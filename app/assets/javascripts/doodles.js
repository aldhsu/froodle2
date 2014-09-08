$(document).ready(function() {
  if (location.pathname.indexOf('/doodles/new') >= 0) {
    // Drawing Functions and Vars
    var canvas = document.getElementById('canvas');
    var context = canvas.getContext('2d');
    var color = "fffff";

    function getMousePos(canvas, event){
      var rect = canvas.getBoundingClientRect();
      return {
        x: event.clientX - rect.left,
        y: event.clientY - rect.top
      };
    }

    function draw(oldposition, canvas, event, context) {
      var mousepos = getMousePos(canvas, event);
      context.beginPath();
      context.moveTo(mousepos.x, mousepos.y);
      context.lineTo(oldposition.x, oldposition.y);
      context.strokeStyle = color;
      context.lineWidth = 15;
      context.stroke();
      return mousepos;
    }
    var oldposition = null;
    var drawing = false;
    var dirty = false;
    // Drawing Listeners convert to websockets
    canvas.addEventListener("mousedown", function(event) {
      oldposition = getMousePos(canvas, event);
      drawing = true;
      dirty = true;
    })
    canvas.addEventListener("mouseup", function(event) {
      drawing = false;
    })
    canvas.addEventListener("mouseout", function(event) {
      drawing = false;
    })

    canvas.addEventListener("mousemove", function(event) {
      if (oldposition == null) {
        oldposition = getMousePos;
      }
      if (drawing == true) {
        oldposition = draw(oldposition, canvas, event, context);
      }
    })

    $(".swatch").click(function(){
      color = $(this).attr("hex");
    })
    // Submitting
    // Create Data Blob
    function dataUrltoBlob(dataUrl) {
      var binary = atob(dataUrl.split(',')[1]);
      var array = [];
      for (var i = 0; i < binary.length; i++) {
        array.push(binary.charCodeAt(i));
      }
      return new Blob([new Uint8Array(array)], {type:'image/png'});
    }
    var button = document.getElementById('submit');
    // Turn to FormData
    function formData() {
      var file = dataUrltoBlob(canvas.toDataURL());
      var fd = new FormData();
      fd.append("image", file);
      fd.append("question", document.getElementById('question').innerHTML);
      return fd;
    }
    // Ajax Submit
    function submitPicture() {
      if (dirty) {
        $.ajax({
          url: "/doodles",
          type: "POST",
          beforeSend: function(xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
          )},
          data: formData(),
          processData: false,
          contentType: false,
          success: function() {
            window.location = '/doodles/new';
          }
        })
      } else {
        window.location = '/doodles/new'
      }
    }
    button.addEventListener("click", function() {
      submitPicture();
    })

    var Timer;
    var TotalSeconds;

    function CreateTimer(TimerID, Time) {
      Timer = document.getElementById(TimerID);
      TotalSeconds = Time;
      UpdateTimer();
      window.setTimeout(Tick(), 1000);
    }

    function Tick() {
      TotalSeconds -= 1;
      UpdateTimer();
      if (TotalSeconds == 60) {
        console.log('finish');
        submitPicture();
      }
      window.setTimeout(Tick, 1000);
    }

    function UpdateTimer() {
      Timer.innerHTML = "Submit " + TotalSeconds;
    }

    window.onload = CreateTimer("submit", 60);
  }
})