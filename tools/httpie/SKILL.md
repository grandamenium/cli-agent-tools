---
name: httpie-cli
description: Use HTTPie (http/https commands) for human-friendly API testing and debugging from the terminal. Simpler syntax than curl with automatic JSON handling.
---

# HTTPie

Human-friendly HTTP client for the terminal. Simpler than curl with automatic JSON, syntax highlighting, and sensible defaults.

- **Official repo:** https://github.com/httpie/cli
- **Docs:** https://httpie.io/docs/cli

## Common Commands

### GET Requests
```bash
http GET https://api.example.com/users
https api.example.com/users                  # https shorthand
http api.example.com/users                   # http shorthand
http api.example.com/users?page=2            # Query params
http api.example.com/users page==2 limit==10 # Query params (cleaner)
```

### POST Requests
```bash
http POST api.example.com/users name=John email=john@test.com   # JSON body
http POST api.example.com/users name=John age:=30               # := for non-string
http POST api.example.com/users tags:='["a","b"]'               # := for arrays/objects
http --form POST api.example.com/upload file@./photo.jpg        # Form data / file upload
```

### PUT / PATCH / DELETE
```bash
http PUT api.example.com/users/1 name=Jane
http PATCH api.example.com/users/1 status=active
http DELETE api.example.com/users/1
```

### Headers and Auth
```bash
http api.example.com/users Authorization:"Bearer TOKEN"
http api.example.com/users X-Custom-Header:value
http -a user:pass api.example.com/users      # Basic auth
http --auth-type bearer --auth TOKEN api.example.com/users  # Bearer auth
```

### Output Control
```bash
http api.example.com/users --print=b         # Body only
http api.example.com/users --print=h         # Headers only
http api.example.com/users --print=hb        # Headers + body
http -b api.example.com/users                # Body only shorthand
http -h api.example.com/users                # Headers only shorthand
http --json api.example.com/users            # Force JSON
http --download api.example.com/file.zip     # Download file
```

### Sessions
```bash
http --session=mysession api.example.com/login user=admin pass=secret
http --session=mysession api.example.com/protected   # Reuses cookies/auth
```

## Agent Best Practices

- Use `-b` (body only) for clean output when piping to jq
- Use `--print=b` for scripts, default output includes headers
- Use `:=` for non-string JSON values (numbers, booleans, arrays)
- Use `--session` for APIs that require login cookies
- Use `--check-status` to exit with error on 4xx/5xx responses
- Pipe to jq for further processing: `http -b api.example.com/users | jq '.data'`
- Use `--offline` to preview requests without sending them

## Example Workflows

### Test an API endpoint
```bash
http -b GET api.example.com/health | jq '.status'
```

### Create a resource with JSON body
```bash
http POST api.example.com/posts \
  title="My Post" \
  body="Content here" \
  published:=true \
  tags:='["dev","cli"]'
```
