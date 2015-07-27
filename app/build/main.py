#!/usr/bin/env python3.4
# -*- coding: utf-8 -*-
import tornado.web

class MainHandler(tornado.web.RequestHandler):
  """
  """
  def get(self):
    """ Override
    """
    self.write("Hello Docker!")


application = tornado.web.Application([
  (r"/", MainHandler),
])
