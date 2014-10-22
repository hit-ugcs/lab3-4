# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  counter = 0

  $('table').delegate 'a[data-submit]', 'click', ->
    selector = $(this).attr('data-form-id')
    alert 'form#' + selector
    $.ajax
      type: 'post',
      url: '/students.json',
      data: $('form#' + selector).serialize(),
      success: (data) ->
        console.log(data)
        $('tr#' + selector).replaceWith(data)
    $(selector).ajaxForm(url: '/students', type: 'post')

  $("#new").click ->
    counter += 1
    #$("tbody").append("<tr id=\"form-#{counter}\"></tr>")
    $("<form action='/students.json' method='post' id=\"form-#{counter}\"></form>")
    $("<tr id=\"form-#{counter}\"></tr>")
      .append('<td><input id="student_studentid" name="student[studentid]" type="number" /></td>')
      .append('<td><input id="student_studentname" name="student[studentname]" type="text" /></td>')
      .append('<td><input id="student_nickname" name="student[nickname]" type="text" /></td>')
      .append('<td><input id="student_projectscore" name="student[projectscore]" type="number" data-score-field data-maxima=40 /></td>')
      .append('<td><input id="student_finalscore" name="student[finalscore]" type="number" data-score-field data-maxima=40 /></td>')
      .append('<td><input id="student_labscore" name="student[labscore]" type="number" data-score-field data-maxima=10 /></td>')
      .append('<td><input id="student_classscore" name="student[classscore]" type="number" data-score-field data-maxima=10 /></td>')
      .append('<td><input id="final" type="number" disabled /></td>')
      .append("<td><a data-submit data-form-id=\"form-#{counter}\">SUBMIT</a></td>")
      .appendTo($("tbody"))

    # maxima validation
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





