# Contributing to this Homebrew Tap

Thank you for your interest in contributing to this Homebrew tap!

## How to Contribute

### For Package Maintainers

If you maintain a package that you'd like to add to this tap:

1. Fork this repository
2. Create a new branch for your formula/cask
3. Add your formula to `Formula/` or cask to `Casks/`
4. Test your formula/cask locally (see Testing section below)
5. Submit a pull request

### Formula Guidelines

Formulae should follow these guidelines:

- Place formulae in the `Formula/` directory
- Name files with lowercase and hyphens (e.g., `my-tool.rb`)
- Follow the [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- Include a `test do` block to verify installation
- Add a meaningful description with `desc`
- Include the project homepage with `homepage`
- Specify the license with `license`

Example formula structure:

```ruby
class MyTool < Formula
  desc "Brief description of your tool"
  homepage "https://github.com/username/my-tool"
  url "https://github.com/username/my-tool/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "abc123..."
  license "MIT"

  depends_on "rust" => :build  # Build dependencies

  def install
    # Installation steps
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/my-tool", "--version"
  end
end
```

### Cask Guidelines

Casks should follow these guidelines:

- Place casks in the `Casks/` directory
- Name files with lowercase and hyphens (e.g., `my-app.rb`)
- Follow the [Homebrew Cask Cookbook](https://docs.brew.sh/Cask-Cookbook)
- Include app name, description, and homepage
- Add `zap` stanza for complete uninstallation

Example cask structure:

```ruby
cask "my-app" do
  version "1.0.0"
  sha256 "abc123..."

  url "https://github.com/username/my-app/releases/download/v#{version}/MyApp-#{version}.dmg"
  name "My App"
  desc "Brief description of your application"
  homepage "https://github.com/username/my-app"

  app "MyApp.app"

  zap trash: [
    "~/Library/Application Support/MyApp",
    "~/Library/Preferences/com.example.myapp.plist",
  ]
end
```

## Testing

### Testing Formulae

Before submitting a formula, test it locally:

```bash
# Install from source
brew install --build-from-source ./Formula/my-tool.rb

# Run tests
brew test ./Formula/my-tool.rb

# Audit the formula
brew audit --strict ./Formula/my-tool.rb

# Uninstall
brew uninstall my-tool
```

### Testing Casks

Before submitting a cask, test it locally:

```bash
# Install the cask
brew install --cask ./Casks/my-app.rb

# Audit the cask
brew audit --strict --cask ./Casks/my-app.rb

# Uninstall
brew uninstall --cask my-app
```

## Automated Releases

If you're setting up automated releases from your project:

1. Ensure you have the `HOMEBREW_TAP_GITHUB_TOKEN` secret configured
2. Follow the instructions in the README for setting up your CI/CD pipeline
3. Test the automation in a separate branch first

## Code of Conduct

- Be respectful and constructive in all interactions
- Follow Homebrew's [Code of Conduct](https://github.com/Homebrew/brew/blob/master/CODE_OF_CONDUCT.md)
- Keep formulae and casks up to date

## Questions?

If you have questions about contributing, please open an issue in this repository.
