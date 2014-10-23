# Grading Worksheet

Grading worksheet is a simple SaaS application for HIT CST SE 2014 Fall class, which can record students' grades. The UI and UX of GW also is fantastic.

## Characteristic Features

### Add row directly

![](https://raw.githubusercontent.com/hit-ugcs/lab3-4/master/public/images/row.png)

You can add rows directly as many as you like by click the **And Row** button in GW homepage, and you can post the data by click the **upload** icon once you feel ready. This function is so convenient that you won't jump to a new page to add some grade record.

### Sum the score online

![](https://raw.githubusercontent.com/hit-ugcs/lab3-4/master/public/images/sum.png)

GW can sum the four types of score online without post it to server. It also will give you right answer if you prefer post the data to server at first.

### Front-end validation

GW can validate the data when the control lose focus. A `.error` class(which means it will shown in red background and yello text) will be added to the input control if the value is too large or too small.

One thing is important: while the front-end validates the data, the backend also validates it before save to database.

## Setup

1. glone this repository.
2. run `bundle`, this may require super user perimission.
3. run `bundle exec rake db:migrate`, this is **IMPORTANG**, without this step, you may receive some errors.

Feel free to use it and report issues.
