# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

news = Category.create({name: '新闻', ename: 'news', display_order: 1})
Category.create({name:'公告', ename: 'notify', display_order: 1, parent: news})
Category.create({name:'活动', ename: 'event', display_order: 2, parent: news})
Category.create({name:'行业动态', ename: 'trend', display_order: 3, parent: news})

about = Category.create({name: '关于', ename: 'about', display_order: 3})
Category.create({name:'简介', ename: 'intro', display_order: 1, parent: about})
Category.create({name:'章程', ename: 'charter', display_order: 2, parent: about})
Category.create({name:'组织结构', ename: 'org', display_order: 3, parent: about})
Category.create({name:'协会领导', ename: 'leader', display_order: 4, parent: about})
Category.create({name:'入会指引', ename: 'join', display_order: 5, parent: about})
