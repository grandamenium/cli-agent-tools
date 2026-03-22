#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOOLS_DIR="$SCRIPT_DIR/tools"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# All available categories
ALL_CATEGORIES="devops cloud database deployment media utility communication testing"

usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Install CLI tools for AI agents."
    echo ""
    echo "Options:"
    echo "  --all                Install all tools"
    echo "  --category CATEGORY  Install tools in a specific category"
    echo "  --tool TOOL          Install a specific tool by directory name"
    echo "  --list               List all available tools"
    echo "  --list-categories    List all categories"
    echo "  --dry-run            Show what would be installed without installing"
    echo "  --help               Show this help message"
    echo ""
    echo "Categories: $ALL_CATEGORIES"
    echo ""
    echo "Examples:"
    echo "  $0 --all                        # Install everything"
    echo "  $0 --category cloud             # Install AWS, gcloud, az"
    echo "  $0 --category utility           # Install jq, rg, ngrok, pandoc, gh-copilot"
    echo "  $0 --tool github --tool docker  # Install specific tools"
    echo "  $0 --list                       # See all available tools"
}

list_tools() {
    echo -e "${BLUE}Available CLI tools:${NC}"
    echo ""
    printf "%-15s %-12s %s\n" "DIRECTORY" "CATEGORY" "DESCRIPTION"
    printf "%-15s %-12s %s\n" "---------" "--------" "-----------"

    # Read from registry.json
    if command -v jq &>/dev/null; then
        jq -r '.tools[] | "\(.directory)|\(.category)|\(.description)"' "$SCRIPT_DIR/registry.json" | while IFS='|' read -r dir cat desc; do
            printf "%-15s %-12s %s\n" "$dir" "$cat" "$desc"
        done
    else
        for dir in "$TOOLS_DIR"/*/; do
            dirname=$(basename "$dir")
            printf "%-15s\n" "$dirname"
        done
    fi
    echo ""
    echo "Total: $(ls -d "$TOOLS_DIR"/*/ 2>/dev/null | wc -l | tr -d ' ') tools"
}

list_categories() {
    echo -e "${BLUE}Available categories:${NC}"
    echo ""
    if command -v jq &>/dev/null; then
        jq -r '.categories | to_entries[] | "  \(.key): \(.value)"' "$SCRIPT_DIR/registry.json"
    else
        echo "  $ALL_CATEGORIES"
    fi
}

get_tools_for_category() {
    local category="$1"
    if command -v jq &>/dev/null; then
        jq -r --arg cat "$category" '.tools[] | select(.category == $cat) | .directory' "$SCRIPT_DIR/registry.json"
    fi
}

install_tool() {
    local tool_dir="$1"
    local install_script="$TOOLS_DIR/$tool_dir/install.sh"

    if [ ! -f "$install_script" ]; then
        echo -e "${RED}No install script found for $tool_dir${NC}"
        return 1
    fi

    echo -e "${BLUE}Installing $tool_dir...${NC}"
    if bash "$install_script"; then
        echo -e "${GREEN}Successfully installed $tool_dir${NC}"
    else
        echo -e "${RED}Failed to install $tool_dir${NC}"
        return 1
    fi
    echo ""
}

# Parse arguments
TOOLS_TO_INSTALL=()
DRY_RUN=false

if [ $# -eq 0 ]; then
    usage
    exit 0
fi

while [ $# -gt 0 ]; do
    case "$1" in
        --all)
            for dir in "$TOOLS_DIR"/*/; do
                TOOLS_TO_INSTALL+=("$(basename "$dir")")
            done
            shift
            ;;
        --category)
            shift
            if [ -z "$1" ]; then
                echo "Error: --category requires a value"
                exit 1
            fi
            tools=$(get_tools_for_category "$1")
            if [ -z "$tools" ]; then
                echo -e "${RED}Unknown category: $1${NC}"
                list_categories
                exit 1
            fi
            while IFS= read -r tool; do
                TOOLS_TO_INSTALL+=("$tool")
            done <<< "$tools"
            shift
            ;;
        --tool)
            shift
            if [ -z "$1" ]; then
                echo "Error: --tool requires a value"
                exit 1
            fi
            if [ ! -d "$TOOLS_DIR/$1" ]; then
                echo -e "${RED}Unknown tool: $1${NC}"
                echo "Run '$0 --list' to see available tools."
                exit 1
            fi
            TOOLS_TO_INSTALL+=("$1")
            shift
            ;;
        --list)
            list_tools
            exit 0
            ;;
        --list-categories)
            list_categories
            exit 0
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

if [ ${#TOOLS_TO_INSTALL[@]} -eq 0 ]; then
    echo "No tools selected."
    exit 0
fi

# Remove duplicates
TOOLS_TO_INSTALL=($(echo "${TOOLS_TO_INSTALL[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

echo -e "${BLUE}Tools to install (${#TOOLS_TO_INSTALL[@]}):${NC}"
for tool in "${TOOLS_TO_INSTALL[@]}"; do
    echo "  - $tool"
done
echo ""

if [ "$DRY_RUN" = true ]; then
    echo -e "${YELLOW}Dry run - no tools were installed.${NC}"
    exit 0
fi

# Install
SUCCESS=0
FAILED=0
for tool in "${TOOLS_TO_INSTALL[@]}"; do
    if install_tool "$tool"; then
        ((SUCCESS++))
    else
        ((FAILED++))
    fi
done

echo -e "${BLUE}---${NC}"
echo -e "${GREEN}Installed: $SUCCESS${NC}"
if [ $FAILED -gt 0 ]; then
    echo -e "${RED}Failed: $FAILED${NC}"
fi
