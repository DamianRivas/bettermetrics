# BetterMetrics

Analytics webapp built with Ruby on Rails

## Register Your Application

When you register you website/webapp, you may want to follow the following format exactly, without a backslash "`/`" at the end.

`http://localhost:3001`

`https://www.example.com`

## Run the API

An easy way to test the API is to send a request with AJAX like the following:

```
let blocmetrics = {};
// eventName is the name of the event as a string
blocmetrics.report = eventName => {
  let event = {event: { name: eventName }};
  let request = new XMLHttpRequest();

  request.open("POST", "http://localhost:3000/api/events", true);
  request.setRequestHeader('Content-Type', 'application/json');
  request.send(JSON.stringify(event));
}
```
