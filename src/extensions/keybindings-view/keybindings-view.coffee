{View, $$} = require 'space-pen'

module.exports =
class KeybindingsView extends View
  @activate: (rootView, state) ->
    requireStylesheet 'keybinding-view.css'
    @instance = new this(rootView)

  @content: (rootView) ->
    @div class: 'keybindings-view', tabindex: -1, =>
      @ul outlet: 'keybindingList'

  initialize: (@rootView) ->
    @rootView.on 'keybindings-view:attach', => @attach()
    @on 'keybindings-view:detach', => @detach()
    @on 'core:page-up', => @pageUp()
    @on 'core:page-down', => @pageDown()
    @on 'core:move-to-top', => @scrollToTop()
    @on 'core:move-to-bottom', => @scrollToBottom()

  attach: ->
    @keybindingList.empty()
    @keybindingList.append $$ ->
      for keystroke, command of rootView.activeKeybindings()
        @li =>
          @span class: 'keystroke', "#{keystroke}"
          @span ":"
          @span "#{command}"

    @rootView.append(this)
    @focus()

  detach: ->
    super()
    @rootView.focus()
