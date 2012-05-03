#!/bin/bash
# amaroK info display script by eirc <eirc.eirc@gmail.com>
#
# requirements: amaroK (!)
# for Collection stats to work amarok must be using
# mySQL to store it's collection

case "$1" in

# Now Playing Info
artist) dcop amarok player artist ;;
title)  dcop amarok player title ;;
album)  dcop amarok player album ;;
year)   dcop amarok player year ;;
genre)  dcop amarok player genre ;;
progress)
    curr=`dcop amarok player trackCurrentTime`
    tot=`dcop amarok player trackTotalTime`
    if (( $tot )); then
        expr $curr \* 100  / $tot
    fi
    ;;

# Collection Info
totalArtists)      dcop amarok collection totalArtists ;;
totalAlbums)       dcop amarok collection totalAlbums ;;
totalTracks)       dcop amarok collection totalTracks ;;
totalGenres)       dcop amarok collection totalGenres ;;
totalCompilations) dcop amarok collection totalCompilations ;;

# Collection Stats
most_songs_by_artist) dcop amarok collection query 'SELECT t1.name FROM artist t1 INNER JOIN tags t2 ON t1.id = t2.artist GROUP BY t2.artist ORDER BY COUNT(t2.artist) DESC LIMIT 1;' ;;
most_songs_by_artist_n) dcop amarok collection query 'SELECT count(t2.artist) FROM artist t1 INNER JOIN tags t2 ON t1.id = t2.artist GROUP BY t2.artist ORDER BY COUNT(t2.artist) DESC LIMIT 1;' ;;
most_songs_are_genre) dcop amarok collection query 'SELECT t1.name FROM genre t1 INNER JOIN tags t2 ON t1.id = t2.genre GROUP BY t2.genre ORDER BY COUNT(t2.genre) DESC LIMIT 1;' ;;
most_songs_are_genre_n) dcop amarok collection query 'SELECT count(t2.genre) FROM genre t1 INNER JOIN tags t2 ON t1.id = t2.genre GROUP BY t2.genre ORDER BY COUNT(t2.genre) DESC LIMIT 1;' ;;
most_songs_during_year) dcop amarok collection query 'SELECT t1.name FROM year t1 INNER JOIN tags t2 ON t1.id = t2.year GROUP BY t2.year ORDER BY COUNT(t2.year) DESC LIMIT 1;' ;;
most_songs_during_year_n) dcop amarok collection query 'SELECT count(t2.year) FROM year t1 INNER JOIN tags t2 ON t1.id = t2.year GROUP BY t2.year ORDER BY COUNT(t2.year) DESC LIMIT 1;' ;;
most_albums_by_artist) dcop amarok collection query 'SELECT name FROM artist WHERE id=(SELECT t1.artist from (SELECT artist FROM tags GROUP BY album) AS t1 GROUP BY t1.artist ORDER BY count(artist) DESC LIMIT 1);' ;;
most_albums_by_artist_n) dcop amarok collection query 'SELECT count(artist) from (SELECT artist FROM tags GROUP BY album) AS t1 GROUP BY t1.artist ORDER BY count(artist) DESC LIMIT 1;' ;;
most_albums_are_genre) dcop amarok collection query 'SELECT name FROM genre WHERE id=(SELECT t1.genre from (SELECT genre FROM tags GROUP BY album) AS t1 GROUP BY t1.genre ORDER BY count(genre) DESC LIMIT 1);' ;;
most_albums_are_genre_n) dcop amarok collection query 'SELECT count(genre) from (SELECT genre FROM tags GROUP BY album) AS t1 GROUP BY t1.genre ORDER BY count(genre) DESC LIMIT 1;' ;;
most_albums_during_year) dcop amarok collection query 'SELECT name FROM year WHERE id=(SELECT t1.year from (SELECT year FROM tags GROUP BY album) AS t1 GROUP BY t1.year ORDER BY count(year) DESC LIMIT 1);' ;;
most_albums_during_year_n) dcop amarok collection query 'SELECT count(year) from (SELECT year FROM tags GROUP BY album) AS t1 GROUP BY t1.year ORDER BY count(year) DESC LIMIT 1;' ;;

esac
