React         = require 'react'
Panel         = require './panel.cjsx'
TextInput     = require '../common/text_input.cjsx'
CourseActions = require('../../actions/course_actions.js').default
ServerActions = require('../../actions/server_actions.js').default

TimelinePanel = React.createClass(
  displayName: 'TimelinePanel'
  updateDetails: (value_key, value) ->
    to_pass = @props.course
    to_pass[value_key] = value
    CourseActions.updateCourse to_pass, true
  render: ->
    timeline_start_props =
      minDate: moment(@props.course.start)
      maxDate: moment(@props.course.timeline_end).subtract(Math.max(1, @props.weeks), 'week')
    timeline_end_props =
      minDate: moment(@props.course.timeline_start).add(Math.max(1, @props.weeks), 'week')
      maxDate: moment(@props.course.end)

    raw_options = (
      <div className='vertical-form'>
        <TextInput
          onChange={@updateDetails}
          value={@props.course.timeline_start}
          value_key='timeline_start'
          editable=true
          type='date'
          label='Assignment Start'
          date_props={timeline_start_props}
        />
        <TextInput
          onChange={@updateDetails}
          value={@props.course.timeline_end}
          value_key='timeline_end'
          editable=true
          type='date'
          label='Assignment End'
          date_props={timeline_end_props}
        />
      </div>
    )

    <Panel {...@props} raw_options={raw_options} />

)

module.exports = TimelinePanel
