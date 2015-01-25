/**
 * Populate DB with sample data on server start
 * to disable, edit config/environment/index.js, and set `seedDB: false`
 */

'use strict';

var sqldb = require('../sqldb');
var Thing = sqldb.Thing;
var User = sqldb.User;
var Image = sqldb.Image;
var Post = sqldb.Post;

Image.sync()
  .then(function(){
    return Image.destroy();
  });

Post.sync()
  .then(function(){
    return Post.destroy();
  })
  .then(function(){
    var defaultPost=function(number){
      return{
        title:'A Generic Post Title #'+number,
        subTitle:'This is just an example, you can make your own later in the admin dashboard',
        content:'<p><a class="asset-img-link" href="http://everything.typepad.com/.a/6a00d83451c82369e201a73dd6fd03970d-pi"><img alt="Avoid Common Blogging Mistakes - Filler Content" class="asset asset-image at-xid-6a00e5521e0e2e883401a3fd3c29f5970b img-responsive" src="http://mustbetuesday.typepad.com/.a/6a00e5521e0e2e883401a3fd3c29f5970b-600wi" style="width: 595px; display: block; margin-left: auto; margin-right: auto;" title="Avoid Common Blogging Mistakes - Filler Content" /></a></p> <blockquote> <p><em>Welcome to our series on common blogging mistakes, and how to avoid them. Every other week, we&#39;ll debut a new post designed to help you avoid mistakes that are common to both new and veteran bloggers, full of tips and tricks guaranteed to help you become an even more passionate, engaged blogger with a growing audience. </em></p> </blockquote> <p>In light of the recent Google Panda algorithm sending some bloggers&#39; statistics into decline, one of the more common issues that bloggers reported being penalized for was having what we refer to as a filler post.</p> <p>A filler post is one that doesn&#39;t consist of much content: a lone image or file; or a short paragraph without substance. The rare filler post, served as a quick update to your readers, may be acceptable, but we highly encourage blog owners to consider how they can write a more complete post so as not to be penalized for something that&#39;s avoidable.</p> <h3>Ways to Kill the Cheap Fill</h3> <ul> <li><em>Can&#39;t keep up with your posting schedule?<br /></em>Decide whether you need to change it to make it less demanding (it <em>is</em> your blog after all). Post your best and you won&#39;t disappoint yourself or your readers, even if that means posting once a week or less.</li> <li><em>In a creative funk?</em> <br />Make better use of when you&#39;re feeling your most creative by jotting down notes, taking photographs, mapping destinations, writing a bulleted list, creating pie charts—it&#39;s up to you! Once you have those items, you can use the momentum to create drafts of posts in your blog that you can then go back to develop at a later time. This can help rejuvenate you when you&#39;re in a slump, saves you time, and reduces stress.</li> <li>S<em>till don&#39;t feel like some of your post topics can stand on their own just yet?</em> <br />Shelve them and go back to them later! Or perhaps what you need to do is challenge yourself in some way related to the topic—consider all angles, try something different, approach it from another direction, or completely flip it on its head and do the unexpected. Work it until it solidifies. Don&#39;t chew it to death, but there should be meat enough to entice the reader to keep looking, keep reading, and to keep coming back for more.</li> </ul> <h3>When You Can&#39;t Avoid the Fill? Reinvent it.</h3> <p>Reinvent what a filler post means for your blog. Instead of publishing a post that&#39;s essentially a fluffy bit of nothing, change what filler content means for your blog, <em>without</em> the fear of search engine penalties. How you choose to reinvent it is up to you, as well as what your goals are for your blog. You can brainstorm and decide what&#39;s right for you, but here are a few ideas to get the wheels turning:</p> <ul> <li><em>Invite guest bloggers to post on a specific topic</em>.<br />This can be something you&#39;d like to cover as well, giving readers different views on the same topic, or it can be something you&#39;d like to learn more about and think your readers would as well.</li> <li><em>Write up a report on some event or thing.</em><br />This doesn&#39;t have to be a book report like the ones that made your insides squirm back in your school days (unless you were a lovable nerd like some of the support staff who <em>loved</em> book report days). Take a step back and consider how your readers might be curious about some of the things you do, create, have, succeeded or failed at, and so on. You may not have thought it would be of interest to them, but we bet there are more than you think.</li> <li><em>Start a discussion with your readers.</em><br />Blogging doesn&#39;t have to be a one-way street—in fact, it really shouldn&#39;t be, unless that&#39;s what you prefer. Posting discussion points, and trying to engage your readers, is more than just slapping questions in a post. Take care to answer them yourself so that it&#39;s communicative and real content. An added bonus of building a community through discussion is that it can provide a place where an unexpected exchange of ideas happens, giving you more to write about at a later time.</li> </ul> <h3>Quantity Isn&#39;t Everything</h3> <p>An important factor to remember about blogging is that the amount of posts you publish each week, month, or ever, isn&#39;t everything; that should never be your real goal. Quality beats quantity every time, and why that is lies in one aspect of blogging that is often forgot: the general format of blog posts and blogging is setup to foster connections.</p> <p>Readers want to establish a connection, to find something interesting in what you say and share—to find that common denominator so they can relate. Giving anything less than that to your blog, and to your readers, so that you can appear to have more real content than you do, can become exhausting—more to the point, disheartening.</p> <p>To feel like the quality of your work means something, and to avoid having your blog penalized for filler, strive for the quality. Stop thinking about filling the gaps between published dates. You&#39;ll find that even some of your shorter posts become less fill and more substance.</p> <p>Have thoughts about filler posts and how to avoid them? Leave a comment and let us know!</p>'
      }
    }
    Post.bulkCreate([
      defaultPost(1),
      defaultPost(2),
      defaultPost(3),
      defaultPost(4),
      defaultPost(5),
      defaultPost(6)
    ])
  });

Thing.sync()
  .then(function() {
    return Thing.destroy();
  })
  .then(function() {
    Thing.bulkCreate([{
      name : 'Development Tools',
      info : 'Integration with popular tools such as Bower, Grunt, Karma, ' +
             'Mocha, JSHint, Node Inspector, Livereload, Protractor, Jade, ' +
             'Stylus, Sass, CoffeeScript, and Less.'
    }, {
      name : 'Server and Client integration',
      info : 'Built with a powerful and fun stack: MongoDB, Express, ' +
             'AngularJS, and Node.'
    }, {
      name : 'Smart Build System',
      info : 'Build system ignores `spec` files, allowing you to keep ' +
             'tests alongside code. Automatic injection of scripts and ' +
             'styles into your index.html'
    }, {
      name : 'Modular Structure',
      info : 'Best practice client and server structures allow for more ' +
             'code reusability and maximum scalability'
    }, {
      name : 'Optimized Build',
      info : 'Build process packs up your templates as a single JavaScript ' +
             'payload, minifies your scripts/css/images, and rewrites asset ' +
             'names for caching.'
    }, {
      name : 'Deployment Ready',
      info : 'Easily deploy your app to Heroku or Openshift with the heroku ' +
             'and openshift subgenerators'
    }]);
  });

User.sync()
  .then(function() {
    User.destroy();
  })
  .then(function() {
    User.bulkCreate([{
      provider: 'local',
      name: 'Test User',
      email: 'test@test.com',
      password: 'test'
    }, {
      provider: 'local',
      role: 'admin',
      name: 'Admin',
      email: 'admin@admin.com',
      password: 'admin'
    },{
      provider: 'stripe',
      role:'admin',
      name:'Admin',
      email:'pgruenbacher@gmail.com',
      password:'admin'
    }])
    .then(function() {
      console.log('finished populating users');
    });
  });
