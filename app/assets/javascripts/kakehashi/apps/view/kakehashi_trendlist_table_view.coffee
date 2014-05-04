App.module 'KAKEHASHI.Views', (Views, App, Backbone, Marionette, $) ->
	# Trend List Item Views
	class Views.ItemView extends Marionette.ItemView
		tagName: 'tr'
		template: 'kakehashi/apps/templates/trend'

		templateHelpers :
			getImageURL: (model)->
				image_url_full = "assets/" + model['tag_type'] + "/" + model['image_url']

			getCount: (model)->
				switch App.KAKEHASHI.controller.period
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
					when 'week'
						rank = model['week_rank']
					when 'month'
						rank = model['month_rank']
					when 'all'
						rank = model['total_rank']
					else
						rank = model['total_rank']

	# Item List View
	class Views.TableListView extends Backbone.Marionette.CompositeView
		template: 'kakehashi/apps/templates/trends'
		itemView: Views.ItemView
		itemViewContainer: '#trend-list'
