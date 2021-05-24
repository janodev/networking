[![Swift](https://github.com/janodev/networking/actions/workflows/swift.yml/badge.svg)](https://github.com/janodev/networking/actions/workflows/swift.yml)

Networking base client. See the [wiki](https://github.com/janodev/networking/wiki).

## Installation

SPM installation:
```
.package(url: "git@github.com:janodev/networking.git", from: "1.0.0"),
```

The following packages will be used as dependencies (you don’t need to install them yourself):
```
.package(url: "git@github.com:janodev/log.git", from: "1.0.0"),
.package(url: "git@github.com:janodev/session.git", from: "1.0.0"),

```

- log: simple log library
- session: A Session protocol that mimics URLSession, so we can stub responses. 
