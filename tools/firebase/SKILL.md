---
name: firebase-cli
description: Use the Firebase CLI to manage hosting, Cloud Functions, Firestore, Authentication, and deploy Firebase projects. Use this instead of the Firebase MCP server.
---

# Firebase CLI

Official CLI for Firebase. Manage hosting, functions, Firestore, auth, and storage.

- **Official repo:** https://github.com/firebase/firebase-tools
- **Docs:** https://firebase.google.com/docs/cli

## Authentication

```bash
firebase login                            # Browser-based login
firebase login --no-localhost             # For remote/headless environments
firebase projects:list                    # List available projects
firebase use PROJECT_ID                   # Select active project
```

## Common Commands

### Project Setup
```bash
firebase init                             # Interactive project setup
firebase init hosting functions firestore # Init specific features
firebase projects:list
firebase use --add                        # Add project alias
```

### Hosting
```bash
firebase deploy --only hosting            # Deploy hosting
firebase hosting:channel:deploy preview   # Preview channel
firebase hosting:channel:list
firebase hosting:disable                  # Take site offline
```

### Cloud Functions
```bash
firebase deploy --only functions                    # Deploy all functions
firebase deploy --only functions:myFunction         # Deploy specific function
firebase functions:log                              # View function logs
firebase functions:shell                            # Interactive function testing
firebase emulators:start --only functions           # Local emulator
```

### Firestore
```bash
firebase firestore:indexes                          # List indexes
firebase firestore:delete --all-collections         # Delete all data (careful!)
firebase emulators:start --only firestore           # Local emulator
```

### Emulators
```bash
firebase emulators:start                            # Start all emulators
firebase emulators:start --only auth,firestore      # Specific emulators
firebase emulators:export ./backup                  # Export emulator data
firebase emulators:start --import=./backup          # Import on start
```

### Extensions
```bash
firebase ext:install firebase/firestore-send-email
firebase ext:list
```

## Agent Best Practices

- Use `firebase emulators:start` for local development and testing
- Deploy specific features with `--only` to avoid unintended changes
- Use `firebase deploy --only hosting` for frontend-only deploys
- Check `firebase use` to confirm active project before deploying
- Use preview channels for testing: `firebase hosting:channel:deploy staging`
- Export/import emulator data to preserve test state

## Example Workflows

### Deploy full project
```bash
firebase deploy
```

### Start local dev environment
```bash
firebase emulators:start --import=./emulator-data --export-on-exit=./emulator-data
```
