# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  counter = 0

  getInputData = (formID, inputID) ->
    $("input##{inputID}[form=#{formID}]").val()

  getFormSerialData = (formID) ->
    utf8: "✓"
    authenticity_token:
      $('meta[name="csrf-token"]').attr('content')
    student: 
      studentid:    parseInt(getInputData(formID, "student_studentid")),
      studentname:  getInputData(formID, "student_studentname"),
      nickname:     getInputData(formID, "student_nickname"),
      projectscore: parseInt(getInputData(formID, "student_projectscore")),
      finalscore:   parseInt(getInputData(formID, "student_finalscore")),
      labscore:     parseInt(getInputData(formID, "student_labscore")),
      classscore:   parseInt(getInputData(formID, "student_classscore"))

  buildRow = (jdata) ->
    $("<tr></tr>")
      .append("<td>#{jdata.studentid}</td>")
      .append("<td>#{jdata.studentname}</td>")
      .append("<td>#{jdata.nickname}</td>")
      .append("<td>#{jdata.projectscore}%</td>")
      .append("<td>#{jdata.finalscore}%</td>")
      .append("<td>#{jdata.labscore}%</td>")
      .append("<td>#{jdata.classscore}%</td>")
      .append("<td>#{jdata.projectscore + jdata.finalscore + jdata.labscore + jdata.classscore}%</td>")
      .append("<td><a href='/students/#{jdata.id}'>Show</a><a href='/students/#{jdata.id}/edit'>Edit</a><a href='/students/#{jdata.id}' data-confirm='Are you sure?' data-method='delete' rel='nofollow'>Destroy</a></td>")

  # submit link clicked
  $('table').delegate 'a[data-submit]', 'click', ->
    selector = $(this).attr('data-form-id')
    console.log getFormSerialData(selector)
    $.ajax
      type: 'post',
      url: '/students.json',
      data: getFormSerialData(selector),
      success: (data) ->
        console.log(data)
        $('tr#' + selector).replaceWith(buildRow(data))
    #$(selector).ajaxForm(url: '/students', type: 'post')

  $("#new").click ->
    counter += 1
    $("#for-form")
      .append("<form action='/students.json' method='post' id=\"form-#{counter}\"></form>")
    $("<tr id=\"form-#{counter}\"></tr>")
      .append("<td><input form=\"form-#{counter}\" id='student_studentid'    name='student[studentid]'    type='number' /></td>")
      .append("<td><input form=\"form-#{counter}\" id='student_studentname'  name='student[studentname]'  type='text' /></td>")
      .append("<td><input form=\"form-#{counter}\" id='student_nickname'     name='student[nickname]'     type='text' /></td>")
      .append("<td><input form=\"form-#{counter}\" id='student_projectscore' name='student[projectscore]' type='number' data-score-field data-maxima=40 /></td>")
      .append("<td><input form=\"form-#{counter}\" id='student_finalscore'   name='student[finalscore]'   type='number' data-score-field data-maxima=40 /></td>")
      .append("<td><input form=\"form-#{counter}\" id='student_labscore'     name='student[labscore]'     type='number' data-score-field data-maxima=10 /></td>")
      .append("<td><input form=\"form-#{counter}\" id='student_classscore'   name='student[classscore]'   type='number' data-score-field data-maxima=10 /></td>")
      .append("<td><input id='final' type='number' disabled /></td>")
      .append("<td><a data-submit data-form-id=\"form-#{counter}\">SUBMIT</a></td>")
      .appendTo($("tbody"))

    # front-end input validation
    $("input[data-score-field]").focusout ->
      ret = 0
      val = parseInt($(this).val())
      maxima = parseInt($(this).attr('data-maxima')) || 0
      if val > maxima or val < 0
        $(this).addClass('error')
        $(this).focus()
      else
        $(this).removeClass('error')
      $("input[data-score-field]").each ->
        ret += parseInt($(this).val()) || 0
      $("#final").val(ret)

    $("tr#form-#{counter}>td>input#student_studentid").focus()

