# Homebrew Tap

This is a custom Homebrew tap for publishing and distributing software packages.

## For Users

### Installing from this tap

Add this tap to your Homebrew installation:

```bash
brew tap fabianopinto/tap https://github.com/fabianopinto/homebrew-tap
```

### List available formulae/casks

```bash
brew search fabianopinto/tap/
```

### Installing a formula

```bash
brew install fabianopinto/tap/<formula-name>
```

### Installing a cask

```bash
brew install --cask fabianopinto/tap/<cask-name>
```

### Updating the tap

```bash
brew update
```

### Removing the tap

```bash
brew untap fabianopinto/tap
```

## For Maintainers

### Publishing to this tap

This tap accepts automated releases from CI/CD pipelines. Releases are published using the `HOMEBREW_TAP_GITHUB_TOKEN` secret.

#### Setting up a project to publish here

1. **Generate a GitHub Personal Access Token (PAT)**

   - Go to GitHub Settings → Developer settings → Personal access tokens → Tokens (classic)
   - Click "Generate new token (classic)"
   - Give it a descriptive name (e.g., "Homebrew Tap Publishing")
   - Select the following scopes:
     - `repo` (Full control of private repositories)
     - `workflow` (Update GitHub Action workflows)
   - Click "Generate token" and copy the token immediately

2. **Add the token to your source project**

   - In your source project repository, go to Settings → Secrets and variables → Actions
   - Click "New repository secret"
   - Name: `HOMEBREW_TAP_GITHUB_TOKEN`
   - Value: Paste the PAT you generated
   - Click "Add secret"

3. **Configure your release workflow**

   Add the following to your GitHub Actions workflow (e.g., `.github/workflows/release.yml`):

   **For Formulae (CLI tools, libraries):**

   ```yaml
   - name: Publish to Homebrew Tap
     env:
       HOMEBREW_TAP_GITHUB_TOKEN: ${{ secrets.HOMEBREW_TAP_GITHUB_TOKEN }}
     run: |
       # Update the formula in the tap
       git clone https://${HOMEBREW_TAP_GITHUB_TOKEN}@github.com/fabianopinto/homebrew-tap.git
       cd homebrew-tap/Formula

       # Update or create your formula file
       cat > your-tool.rb << 'EOF'
       class YourTool < Formula
         desc "Description of your tool"
         homepage "https://github.com/fabianopinto/your-tool"
         url "https://github.com/fabianopinto/your-tool/archive/refs/tags/v${VERSION}.tar.gz"
         sha256 "${SHA256}"
         license "MIT"

         def install
           bin.install "your-tool"
         end

         test do
           system "#{bin}/your-tool", "--version"
         end
       end
       EOF

       git config user.name "github-actions[bot]"
       git config user.email "github-actions[bot]@users.noreply.github.com"
       git add .
       git commit -m "Update your-tool to ${VERSION}"
       git push
   ```

   **For Casks (GUI applications):**

   ```yaml
   - name: Publish to Homebrew Tap
     env:
       HOMEBREW_TAP_GITHUB_TOKEN: ${{ secrets.HOMEBREW_TAP_GITHUB_TOKEN }}
     run: |
       # Update the cask in the tap
       git clone https://${HOMEBREW_TAP_GITHUB_TOKEN}@github.com/fabianopinto/homebrew-tap.git
       cd homebrew-tap/Casks

       # Update or create your cask file
       cat > your-app.rb << 'EOF'
       cask "your-app" do
         version "${VERSION}"
         sha256 "${SHA256}"

         url "https://github.com/fabianopinto/your-app/releases/download/v#{version}/YourApp-#{version}.dmg"
         name "Your App"
         desc "Description of your application"
         homepage "https://github.com/fabianopinto/your-app"

         app "YourApp.app"

         zap trash: [
           "~/Library/Application Support/YourApp",
           "~/Library/Preferences/com.yourcompany.yourapp.plist",
         ]
       end
       EOF

       git config user.name "github-actions[bot]"
       git config user.email "github-actions[bot]@users.noreply.github.com"
       git add .
       git commit -m "Update your-app to ${VERSION}"
       git push
   ```

4. **Alternative: Using homebrew-releaser action**

   You can also use the `Homebrew/actions/homebrew-releaser` action:

   ```yaml
   - name: Update Homebrew tap
     uses: Homebrew/actions/homebrew-releaser@master
     with:
       homebrew_owner: fabianopinto
       homebrew_tap: homebrew-tap
       github_token: ${{ secrets.HOMEBREW_TAP_GITHUB_TOKEN }}
       formula: Formula/your-tool.rb
       version: ${{ github.ref_name }}
   ```

### Manual updates

You can also update formulae/casks manually by cloning this repository and making changes:

```bash
git clone https://github.com/fabianopinto/homebrew-tap.git
cd homebrew-tap

# Make your changes to Formula/*.rb or Casks/*.rb files

git add .
git commit -m "Update formula/cask"
git push
```

### Testing formulae/casks locally

Before pushing changes, test them locally:

```bash
# For formulae
brew install --build-from-source ./Formula/your-tool.rb
brew test ./Formula/your-tool.rb

# For casks
brew install --cask ./Casks/your-app.rb
```

### Formula/Cask naming conventions

- **Formulae**: Use lowercase with hyphens (e.g., `my-tool.rb`)
- **Casks**: Use lowercase with hyphens (e.g., `my-app.rb`)
- **Classes**: Use CamelCase (e.g., `MyTool`, `MyApp`)

## Repository Structure

```
.
├── Formula/          # Homebrew formulae (CLI tools, libraries)
├── Casks/            # Homebrew casks (GUI applications)
├── README.md         # This file
└── LICENSE           # License file
```

## Resources

- [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [Homebrew Cask Cookbook](https://docs.brew.sh/Cask-Cookbook)
- [Acceptable Formulae](https://docs.brew.sh/Acceptable-Formulae)
- [Acceptable Casks](https://docs.brew.sh/Acceptable-Casks)
