$(document).ready(function() {
  Trix.config.attachments.preview.caption = {
    name: false,
    size: false
  };

  function uploadAttachment(attachment) {
    var csrfToken = $('meta[name="csrf-token"]').attr('content');
    var file = attachment.file;
    var form = new FormData;
    var endpoint = "/uploads";
    form.append("Content-Type", file.type);
    form.append("file", file);
    form.append("upload[uploadable_type]", 'Blog');
    form.append("upload[uploadable_id]", '0');
    form.append("authenticity_token", window._token);

    xhr = new XMLHttpRequest;
    xhr.open("POST", endpoint, true);
    xhr.setRequestHeader("X-CSRF-Token", csrfToken);

    xhr.upload.onprogress = function(event) {
      var progress = event.loaded / event.total * 100;
      return attachment.setUploadProgress(progress);
    };

    xhr.onload = function() {
      if (this.status >= 200 && this.status < 300) {
        var data = JSON.parse(this.responseText);
        $('#attachments').val($('#attachments').val() + ',' + data.id);
          return attachment.setAttributes({
          url: data.extra
        });
      }
    };

    return xhr.send(form);
  };

  document.addEventListener("trix-attachment-add", function(event) {
    var attachment = event.attachment;
    if (attachment.file) {
      return uploadAttachment(attachment);
    }
  });
});
