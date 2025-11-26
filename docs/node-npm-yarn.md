# Node.js, NPM, and Yarn

Node.js is available in the development environment for running JavaScript tools, build processes, and applications. Both NPM and Yarn package managers are supported.

## Setup

Node.js is enabled by default during setup. If needed, you can enable it manually:
```bash
mkdir -p conf/node
dev rebuild
```

## Available Commands

### Node.js

Run Node.js scripts:
```bash
dev node script.js
```

Check Node.js version:
```bash
dev node --version
```

### NPM

Install dependencies from package.json:
```bash
dev npm install
```

Install a specific package:
```bash
dev npm install package-name
```

Run npm scripts:
```bash
dev npm run build
dev npm run watch
dev npm run dev
```

### Yarn

Install dependencies:
```bash
dev yarn install
```

Add a package:
```bash
dev yarn add package-name
```

Run yarn scripts:
```bash
dev yarn build
dev yarn watch
```

## Working Directory

All Node.js, NPM, and Yarn commands run in your current directory context. Make sure you're in your project directory before running commands:

```bash
cd workspace/customer/project
dev npm install
```

## Common Use Cases

### Frontend Build Tools

For projects using Webpack, Gulp, Grunt, or similar:
```bash
cd workspace/customer/project
dev npm install
dev npm run build
```

### Magento 2 Theme Compilation

For Magento 2 themes using Gulp or similar:
```bash
cd workspace/customer/project/htdocs
dev npm install
dev npm run build
```

### Watch Mode

For development with file watching:
```bash
dev npm run watch
```

Or with Yarn:
```bash
dev yarn watch
```

## Node.js Version

The environment uses the Node.js version defined in the build configuration. To check which version is available:
```bash
dev node --version
```

## Package Management

Both NPM and Yarn are available. Choose based on your project:
- If `package-lock.json` exists, use `dev npm`
- If `yarn.lock` exists, use `dev yarn`

## Troubleshooting

### Permission Issues

If you encounter permission errors, the Node.js container runs as your user, so permissions should match your local files.

### Module Not Found

Ensure you've installed dependencies:
```bash
dev npm install
```

Or:
```bash
dev yarn install
```

### Cache Issues

Clear NPM cache:
```bash
dev npm cache clean --force
```

Clear Yarn cache:
```bash
dev yarn cache clean
```
