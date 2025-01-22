import catppuccin

config.load_autoconfig()

c.tabs.padding = { 'bottom': 5, 'right': 5, 'left': 5,'top': 5 }
c.completion.height = '35%'
c.statusbar.padding = { 'bottom': 5, 'right': 5, 'left': 5,'top': 5 }
c.fonts.default_family = 'Roboto Mono for Powerline'

c.aliases['op'] = 'spawn --userscript qute_1pass_2'
c.aliases['sum'] = 'spawn --userscript qute_kagi sum'

catppuccin.setup(c, 'mocha', True)
