#!/bin/bash

# Get script directory to resolve relative paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MCP_SOURCE="$SCRIPT_DIR/mcp-config.json"
MCP_LINK="$HOME/.copilot/mcp-config.json"

# Create ~/.copilot directory if it doesn't exist
mkdir -p "$HOME/.copilot"

# Create symlink for mcp-config.json
if [ -L "$MCP_LINK" ] && \
   [ "$(readlink "$MCP_LINK")" = "$MCP_SOURCE" ]; then
    echo "mcp-config.json symlink already points to correct location."
else
    ln -sf "$MCP_SOURCE" "$MCP_LINK"
    echo "Created symlink: $MCP_LINK -> $MCP_SOURCE"
fi

echo "Copilot MCP configuration setup complete!"
