# Render Hooks for Markdown
*note this is only supported with the Goldmark renderer in v0.62 onward*

Allows for custom templates for rendering of images and links. Create templates with base names `render-link` and `render-image` in this directory. Output-format and language specific templates can be specified if need be.

**Sample Folder Structure:**
```markdown
layouts
└── _default
    └── _markup
        ├── render-image.html
        ├── render-image.rss.xml
        └── render-link.html
```

More can be read at https://gohugo.io/getting-started/configuration-markup/#markdown-render-hooks
