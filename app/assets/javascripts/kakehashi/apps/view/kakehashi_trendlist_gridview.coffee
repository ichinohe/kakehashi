App.module 'KAKEHASHI.Views', (Views, App, Backbone, Marionette, $) ->
	# Trend List Item Views
	class Views.ItemView extends Marionette.ItemView
		template: 'kakehashi/apps/templates/trend_grid'

		events:
			'dblclick #trend' :'dblclickBubble'

		onShow: ->
			@appendIsotope()

		appendIsotope: ->
			$('#trend-list').isotope('appended', @$el)

		initTooltip: ->
			$("#bubble-#{@model.get 'keyword_id'}").tooltipster(
				content: $('<span><strong>' + @createTooltipMsg() + '</strong></span>')
				)

		dblclickBubble: ->
			console.log "dblclickBubble"
			window.open("https://twitter.com/intent/tweet?button_hashtag=tag_name&text=messages")

		getCount: ->
			switch App.KAKEHASHI.controller.period
				when 'day'
					count = @model.get 'day_count'
				when 'week'
					count = @model.get 'week_count'
				when 'month'
					count = @model.get 'month_count'
				when 'all'
					count = @model.get 'total_count'
				else
					count = @model.get 'total_count'

		getRank: ->
			switch App.KAKEHASHI.controller.period
				when 'day'
					rank = @model.get 'day_rank'
				when 'week'
					rank = @model.get 'week_rank'
				when 'month'
					rank = @model.get 'month_rank'
				when 'all'
					rank = @model.get 'total_rank'
				else
					rank = @model.get 'total_rank'

		createTooltipMsg: ->
			tag_type = @model.get 'tag_type'
			rank = @getRank()
			name = @model.get 'name'
			origin = @model.get 'land_of_origin'
			count = @getCount()

			msg = 'No.' + rank + '</br>'
			switch tag_type
				when 'sake', 'traditional'
					msg += name + ' @ ' + origin + '</br>'
				when 'anime'
					msg += name + '</br>'
				when 'company'
					msg += name + '</br>'
				else
					msg += name + '</br>'
			msg += '<i class="fa fa-twitter fa-lg"></i>' + count + '</br>'


		templateHelpers :
			getImageURL: (model)->
				image_url_full = "assets/" + model['tag_type'] + "/" + model['image_url']

			getCount: (model)->
				switch App.KAKEHASHI.controller.period
					when 'day'
						count = model['day_count']
					when 'week'
						count = model['week_count']
					when 'month'
						count = model['month_count']
					when 'all'
						count = model['total_count']
					else
						count = model['total_count']

			getRank: (model)->
				switch App.KAKEHASHI.controller.period
					when 'day'
						rank = model['day_rank']
					when 'week'
						rank = model['week_rank']
					when 'month'
						rank = model['month_rank']
					when 'all'
						rank = model['total_rank']
					else
						rank = model['total_rank']

			doesDisplayLandOfOrigin: ->
				tag_type = App.KAKEHASHI.controller.tag_type
				switch tag_type
					when 'sake', 'traditional'
						true
					when 'anime'
						false
					when 'company'
						false
					else
						false

	# Item List View
	class Views.GridListView extends Backbone.Marionette.CompositeView
		template: 'kakehashi/apps/templates/trends_grid'
		itemView: Views.ItemView
		itemViewContainer: '#trend-list'

		onShow: ->
			@initIsotope()
			$(document).foundation()
			if twttr?
				twttr.widgets.load()

		initIsotope: ->
			$('#trend-list').isotope
				itemSelector: '.trend-grid'
				# layoutMode : "fitRows"
				masonry:
					columnWidth: 150

		templateHelpers:
			getCategory: ->
				App.KAKEHASHI.controller.tag_type
