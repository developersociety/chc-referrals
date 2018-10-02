App.status = App.cable.subscriptions.create("ReferralsChannel", {
  received: function(data) {
    if (data.used_referrals >= data.max_referrals) {
      if (window.location.pathname.match(/referrals\/new/)) {
        window.location.reload();
      }
    }

    var el = document.getElementById(data.partner + "-used-referrals");

    if (el) {
      return el.innerHTML = data.used_referrals;
    } else {
      return;
    }
  }
});
