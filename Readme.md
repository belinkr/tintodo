Introduction
============

This is a reference application based on the Tinto architecture. It is inspired
on the TodoMVC project. This part of the reference application implements a
backend suitable for any of the TodoMVC client implementations.

Requirements
============

* JRuby-1.7.0
* tinto-3.0.2
* Redis database

Running the server
===================

To run the server, follow these steps:

1. Install Tinto: gem install tinto/tinto-3.0.2.gem
2. Install other required gems: bundle install
3. Start the server: bundle exec rackup
4. The server will be available at http://localhost:9292

