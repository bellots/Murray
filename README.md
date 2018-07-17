# Murray
Murray is a CLI for creating and managing XCode applications.
Basically, it's like having the XCode template features without having to deal with the Template.plist

## Key Features

- Clone a skeleton template from a remote repository and setup it to be compile-ready
- Use *Bones* to insert a file (or a group of files) in your project string-replacing your placeholders.

# Installation

```
curl -fsSL https://raw.githubusercontent.com/synesthesia-it/Murray/master/install.sh | sh
```

# Usage

Create a new skeleton app (defaults to [Skeleton](https://github.com/synesthesia-it/Skeleton) )
After proper cloning and, the app's bundle is installed if a Gemfile is available

```
$ murray project new CoolApp
```


Next commands should all be used inside your freshly created project's directory.
(example: `~/XCodeProjects/CoolApp`)


Clone a Bones repository and setup current project (defaults to [Bones](https://github.com/synesthesia-it/Bones) )

```
$ murray template setup
```

Install a Bone into your current project
In this case, a `viewSection` is created by replacing placeholders inside the template file with `Product`

```
$ murray template new viewSection Product
```

List all templates available for current project
```
$ murray template list
```

# Bones and Bonespec.json
-- TODO

### Why Murray?

Because we're dealing with Skeleton apps and Bones and we really miss Monkey Island a lot! :)