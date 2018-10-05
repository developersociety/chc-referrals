App.status = App.cable.subscriptions.create("ReferralsChannel", {
  received: function(data) {
    if (data.used_referrals >= data.max_referrals) {
      if (window.location.pathname.match(/referrals\/new/)) {
        window.location.reload();
      }
    }

    var available = document.getElementById(data.partner + "-available-referrals");
    var used = document.getElementById(data.partner + "-used-referrals");

    if (available && used) {
      available.innerText = data.max_referrals - data.used_referrals;
      used.innerText = data.used_referrals;
      return;
    } else {
      return;
    }
  }
});
