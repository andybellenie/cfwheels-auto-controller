<h1>AutoController 1.1</h1><h3>A plugin for <a href="http://cfwheels.org" target="_blank">Coldfusion on Wheels</a> by <a href="http://cfwheels.org/user/profile/24" target="_blank">Andy Bellenie</a></h3>
<p>This plugin is designed to significantly reduce the amount of controller code you need to write by automating the most common controller actions, specifically the creating, updating and deleting of models associated with any particular controller.</p>
<p>Auto-controller follows the Wheels approach of Convention over Configuration and is designed to be used silently with minimal overhead and configuration. In a typical web-app, use of the auto-controller can reduce your controller code by around 80%.</p>
<h2>Basic setup</h2><p>Add autoController() to an init block in your base controller (Controller.cfc in the controller's folder). This enables the auto-controller for all controller's in the application. </p>
<pre>
&lt;cfcomponent extends=&quot;Wheels&quot; output=&quot;false&quot;&gt;
	&lt;cffunction name=&quot;init&quot;&gt;
		&lt;cfset autoController()&gt;
	&lt;/cffunction&gt;<br />&lt;/cfcomponent&gt;
</pre>
<p>Rememeber to add super.init() to any init blocks you may have in controllers that extend the base controller.</p>
<p>You can also add autoController() to a single controller if you don't want its methods to be accessible to all the controller's in your application.</p>
<h2>Usage</h2>
<p>The most important concept to understand is that of the <strong>controller's default model</strong>. This is a link between the controller and one specific model. This is useful because for the majority of applications, each controller tends to deal with one model most of the time. For example, a Users controller will primarily deal with the User model. </p>
<p>By default, the controller model is assumed to be named as the singular of the controller name. So, Users controller = User model.</p>
<p>Auto-controller adds methods for the following controller actions:</p>
<ul>
	<li>index(): calls findAll() on the controller model, returns it as the controller name and renders index.cfm in the controller's view folder. Supports pagination.</li><li>new(): creates	a blank controller model and renders the edit page. If it receives a form submission containing a key in the params scope that matches the controller model, it saves those properties into the blank object and attempts to save it. If succesful, it writes a message to the flash with the key 'success' and redirects to the index action. If the model was not saved it re-render's the action's template (edit.cfm by default).</li>
	<li>edit(): reads the controller model from the database using params.key. If it receives a form submission as described above, it updates the model with the supplied properites, adds a message to the flash with the key 'success' and redirects to the index action. If it cannot update, it re-render's the action's template (edit.cfm by default).</li>
	<li>delete(): reads the controller model from the database using params.key, calls its delete method, adds a message to the flash with the key 'success' and redirects to the index action. If it cannot delete, it writes a message to the flash with the key 'error'.</li>
	<li>loadModel(): a helper method that attempts to load the controller model from the database by using params.key, returning false if it cannot be found.</li>
</ul>
<h2>Say what?</h2>
<p>Ok, that's a bit confusing so I'll give some examples. We have our Users controller, we've loaded autoController() in the base init and now we want to make it work. Using the new action as an example, we create a view called edit.cfm in the views/users/ directory.</p>
<p>We add the following code:</p>
<pre>&lt;cfoutput&gt;
#errorMessagesFor(objectName=&quot;user&quot;)#
#startFormTag()#
	#textField(objectName=&quot;user&quot;, property=&quot;firstNames&quot;)#
	#textField(objectName=&quot;user&quot;, property=&quot;lastName&quot;)#
	#textField(objectName=&quot;user&quot;, property=&quot;emailAddress&quot;)#
	#submitTag()#
#endFormTag()#
&lt;/cfoutput&gt;</pre>
<p>That's it. No controller code is required at all. When the new action is called, the auto-controller creates a blank user object and loads the view. The form is submitted back to the same action. </p>
<p>Now the auto-controller sees the submitted user properties in the params scope, so it populates the user model and attempts to save it, redirecting to the index page if it succesfully does so. If the save fails, the form is shown again, and will output any error messages generated during the save so that the user can correct their input and try again.</p>
<h2>Advanced Configuration</h2>
<p>The default setup of auto-controller is the easiest way to use it, but almost all of it's methods and conventions can be configured, such as the page redirected to after an update, the default template used for the 'new' action, the name of the controller model or the name of variable used. These can be set globally, per controller or per action.</p>
<p>There are three ways to configure the auto-controller. The first is to pass in attributes to the main autoController() call, like this:</p>

<pre>
&lt;cffunction name=&quot;init&quot;&gt;
	&lt;cfset autoController(modelName=&quot;foo&quot;, modelVariable=&quot;objFoo&quot;)&gt;
&lt;/cffunction&gt;</pre>


<p>However, as there are a large number of options available, and many of them may be custom to a specific controller, there are also accessor methods available for all of the configuration parameters. So you could achieve the same as above by doing the following:</p>
<pre>
&lt;cffunction name=&quot;init&quot;&gt;
	&lt;cfset autoController()&gt;
	&lt;cfset modelName(&quot;foo&quot;)&gt;
	&lt;cfset modelVariable(&quot;objFoo&quot;)&gt;
&lt;/cffunction&gt;</pre>
<p>When you have autoController() set in your base controller, this makes it easy to change one or more of the standard configuration options for that controller only by exending the base init() and then adding the additional options using the accessors, like this:</p>
<pre>
&lt;cfcomponent extends=&quot;Controller&quot;&gt;

	&lt;cffunction name=&quot;init&quot;&gt;
		&lt;cfset super.init()&gt;
		&lt;cfset modelName(&quot;foo&quot;)&gt;
		&lt;cfset modelVariable(&quot;objFoo&quot;)&gt;
	&lt;/cffunction&gt;

&lt;/cfcomponent&gt;
</pre>
<p>You can also override the defaults on a per action basis by creating overrides, for example:</p>
<pre>
&lt;cfcomponent extends=&quot;Controller&quot;&gt;

	&lt;cffunction name=&quot;new&quot;&gt;
		&lt;cfset arguments.modelName = &quot;foo&quot;&gt;
		&lt;cfset arguments.modelVariable = &quot;objFoo&quot;&gt;
		&lt;cfset super.new(argumentCollection=arguments)&gt;		
	&lt;/cffunction&gt;

&lt;/cfcomponent&gt;
</pre>
<p>This third method is particularly useful as it allows you to use auto-controller methods on models other than the controller model. For example, if you wanted to also manage permissions within a Users controller, you could add a method like this:</p>
<pre>
&lt;cfcomponent extends=&quot;Controller&quot;&gt;

	&lt;cffunction name=&quot;newPermission&quot;&gt;
		&lt;cfset arguments.modelName = &quot;Permission&quot;&gt;
		&lt;cfset arguments.template = &quot;newPermission&quot;&gt;
		&lt;cfset super.new(argumentCollection=arguments)&gt;		
	&lt;/cffunction&gt;

&lt;/cfcomponent&gt;
</pre>
<p>There are a large number of configuration options available. For full details please look at the plugin code which contains detailed hints on each argument.</p>
<h2>Overriding auto-controller methods</h2>
<p>So you downloaded the plugin, installed it, read this far through the documentation and now you don't want to use it? Well, fine :) If you want to use a custom method for index, new or edit, all you have to do is add the method to your controller without calling super.[actionname] and the auto-controller will be bypassed.</p>
<pre>
&lt;cfcomponent extends=&quot;Controller&quot;&gt;

	&lt;cffunction name=&quot;index&quot;&gt;
		&lt;!--- custom code goes here ---&gt;	
	&lt;/cffunction&gt;

&lt;/cfcomponent&gt;
</pre>
<h2>Support</h2>
<p>I try to keep my plugins free from bugs and up to date with Wheels releases, but if you encounter a problem please log an issue using the tracker on github, where you can also browse my other plugins.<br />
<a href="https://github.com/andybellenie" target="_blank">https://github.com/andybellenie</a></p>
