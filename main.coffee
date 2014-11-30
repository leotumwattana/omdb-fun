$ ->

  search = (title) ->
    $.ajax
      url: "http://www.omdbapi.com/?s=#{title}"
    .done (data) ->
      movies = $.parseJSON(data)['Search']

      for movie in movies
        $('.movies').append "<li><a href='#' data-imdb=#{movie.imdbID}>#{movie.Title}</a></li>"

    .fail (j, t, e) ->
      console.log j, t, e

  details = (imdbID) ->
    $.ajax
      url: "http://www.omdbapi.com/?i=#{imdbID}&tomatoes=true&plot=full"
    .done (data) ->
      movie = $.parseJSON(data)
      console.log movie

      $('.movie-title').html movie.Title
      $('img.poster').attr('src', movie.Poster)
      $('.plot').html movie.Plot

    .fail (j, t, e) ->
      console.log j, t, e

  $('#search').on "submit", (e) ->
    e.preventDefault()
    searchTerm = $('#search input').val()
    search(searchTerm)

  $('.search').delegate "li", "click", (e) ->
    e.preventDefault()
    imdbID = $(e.target).data('imdb')
    details(imdbID)
