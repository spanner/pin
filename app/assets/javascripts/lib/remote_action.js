(function($) { 
  function RemoteAction (url, holder) {
    var self = this;
    $.ajaxSettings.accepts.html = $.ajaxSettings.accepts.script;
    
    $.extend(self, {
      url: url,
      holder: holder,
      container: null,
      form: null,

      fetch: function () {
        if (self.showing()) self.hide();
        else if (self.form) self.show();
        else {
          self.wait();
          $.get(self.url, self.step, 'html');  
        }
      },
    
      submit: function (e) {
        var ajaxable = true;
        // file to upload means not ajaxable at all
        self.container.find('input:file').each(function () {
          var file = $(this).val();
          if (file && file != "") ajaxable = false;
        });
        if (ajaxable) {
          e.preventDefault();
          $.post(self.form.attr('action'), self.form.serialize(), self.step, 'html');  
        } else {
          return true;  // allow event through so that form is sent by normal HTTP POST
        }
      },
      step: function (results) {
        self.unwait();
        if (results) self.container.html(results);
        self.container.find('.cancel').click(self.cancel);
        self.form = self.container.find('form');
        if (self.form.length > 0) {
          // intermediate step: hook up the new form
          self.form.submit(self.submit);
          self.show();
        } else {
          // final step: complete replacement with outcome
          holder.replaceWith(results);
        }
      },
      cancel: function (event) {
        if (event) event.preventDefault();
        self.unwait();
        self.hide();
      },
      show: function () {
        self.unwait();
        self.holder.hide();
        self.container.show();
      },
      hide: function () {
        self.container.hide();
        self.holder.show();
      },
      showing: function () {
        return self.container.is(':visible');
      },
      wait: function () {
        holder.wait();
      },
      unwait: function () {
        holder.unwait();
      }
    });
    self.container = $('<div class="remote_form" />').hide();
    self.holder.append(self.container);
  }

  function ActionHolder(container, conf) {   
    var self = this;
    $.extend(self, {
      container: container,
      wrapper: container.find('.wrapper'),
      actions: {},
      initActions: function () {
        self.actions = {};
        self.container.find('a.remote').each(function () {
          var a = $(this);
          var href = a.attr('href');
          self.addAction(href);
          a.click(function (event) {
            if (event) event.preventDefault();
            a.addClass('waiting');
            self.showAction(href);
          });
          if (a.is('.autoload')) self.showAction(href);
        });
      },
      addAction: function (url) {
        if (!self.actions[url]) self.actions[url] = new RemoteAction(url, self);
        return self.actions[url];
      },
      showAction: function (url) {
        $.each(self.actions, function (key, action) { action.hide(); });
        self.actions[url].fetch();
      },
      append: function (el) {
        return self.container.append(el);
      },
      replaceWith: function (html) {
        self.container.html(html);
        self.wrapper = self.container.find('.wrapper');
        self.initActions();
        return self.container;
      },
      show: function () {
        self.wrapper.show();
      },
      hide: function () {
        self.wrapper.hide();
      },
      toggle: function (event) {
        if (event) event.preventDefault();
        if (self.wrapper.is(":visible")) self.hide();
        else self.show();
      },
      wait: function () {
        self.container.addClass('waiting');
        self.container.find('a.remote').addClass('waiting');
      },
      unwait: function () {
        self.container.removeClass('waiting');
        self.container.find('a.remote').removeClass('waiting');
      }
    });
    self.initActions();
  }

  $.fn.enable_remote_actions = function(conf) {
    this.each(function() {
      new ActionHolder($(this), conf);
    });
    return this;
  };
})(jQuery);
