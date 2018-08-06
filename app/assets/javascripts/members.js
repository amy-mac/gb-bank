// Polyfill for IE
if (!String.prototype.startsWith) {
    String.prototype.startsWith = function(searchString, position){
      return this.substr(position || 0, searchString.length) === searchString;
  };
}

var MemberSearch = {
  init: function() {
    var searchBox = document.getElementById("member_name");
    searchBox.addEventListener("input", this.handleSearchInput, false)
  },
  handleSearchInput: function(event) {
    event.stopPropagation();

    var members = document.querySelectorAll("ol li");
    var searchTerm = this.value.toLowerCase();

    MemberSearch.showAll(members);

    if (members.length && searchTerm !== "") {
      var matches = [].filter.call(members, function(member) {
        return member.innerText.toLowerCase().startsWith(searchTerm);
      });

      MemberSearch.handleFiltering(members, matches);
    }
  },
  handleFiltering: function(members, matches) {
    var nonMatches = $(members).not(matches).get();

    if (matches.length === 0) {
      document.getElementById("js-noResults").classList.remove("hide");
    }

    nonMatches.forEach(function(elem) {
      elem.classList.add("hide");
    });
  },
  showAll: function(members) {
    document.getElementById("js-noResults").classList.add("hide");

    [].forEach.call(members, function(elem) {
      elem.classList.remove("hide");
    });
  }
};

document.addEventListener("turbolinks:load", function() {
  if (document.getElementById("members-index")) {
    MemberSearch.init();
  }
});
