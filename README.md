# skills

Agent skills for [Claude Code](https://docs.anthropic.com/en/docs/claude-code), [Gemini CLI](https://github.com/google-gemini/gemini-cli), and any agent that follows the [agentskills.io](https://agentskills.io/specification) spec.

## Available skills

| Skill | Description | Install |
|-------|-------------|---------|
| [plain-language](plain-language/) | Review text for plain language compliance based on U.S. federal government Plain Language Guidelines | `npx skills add ggwicz/skills --skill plain-language` |

## Install a skill

```bash
# Install
npx skills add ggwicz/skills --skill <skill-name>

# List available skills in this repo
npx skills add ggwicz/skills --list
```

## License

[MIT](LICENSE)
