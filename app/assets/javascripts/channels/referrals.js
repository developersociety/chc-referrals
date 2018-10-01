App.status = App.cable.subscriptions.create("ReferralsChannel", {
  received: function(data) {
    if (data.sent_referrals >= data.max_referrals) {
      window.location.reload();
    }

    var el = document.getElementById(data.partner + "-sent-referrals");

    if (el) {
      return el.innerHTML = data.sent_referrals;
    } else {
      return;
    }
  }
});
