# Autogenerated config.py
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

c.tabs.background = True
c.auto_save.session = True
# c.new_instance_open_target = 'window'
c.downloads.position = 'bottom'
c.statusbar.hide = True
c.tabs.show = "multiple"

c.url.searchengines = {
    "DEFAULT":  "https://duckduckgo.com/?q={}",
    "aw": "https://wiki.archlinux.org/?search={}",
    "aur": "https://aur.archlinux.org/packages/{}",
    "sec": "https://security.archlinux.org/{}",
    "bugs":"https://bugs.archlinux.org/index.php?string={}"
}


config.unbind('u')
config.unbind('d')
config.unbind('@')
config.unbind('q')

config.bind('<ctrl-d>', 'tab-close')
config.bind('J', 'tab-prev')
config.bind('K', 'tab-next')
config.bind('F', 'hint all tab-bg')
config.bind('d', 'scroll-page 0 0.5')
config.bind('u', 'scroll-page 0 -0.5')



theme = {
    'colors': {
        'bg': {
            'normal': '#E3E3E3',
            'active': '#B9B9B9',
            'inactive': '#F7F7F7',
        },

        'fg': {
            'normal': '#464646',
            'active': '#525252',
            'inactive': '#464646',

            # completion and hints
            'match': '#0A0A0A',
        },
    }
}
colors = theme['colors']

# Uncomment this to still load settings configured via autoconfig.yml
# config.load_autoconfig()
