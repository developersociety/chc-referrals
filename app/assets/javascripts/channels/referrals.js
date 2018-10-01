App.status = App.cable.subscriptions.create("ReferralsChannel", {
  received: function(data) {
    var el = document.getElementById(data.partner + "-sent-referrals");

    if (el) {
      return el.innerHTML = data.sent_referrals;
    } else {
      return;
    }
  }
});
