<cfcomponent displayname="Auto Controller" output="false">

	
	<cffunction name="init" output="false">
		<cfset this.version = "1.1">
		<cfreturn this>
	</cffunction>
	
	
	<cffunction name="autoController" returntype="void" output="false" mixin="controller">
		<cfargument name="modelName" type="string" default="#Singularize(variables.$class.name)#" hint="I am the name of the controller's default model (defaults to the singular of the controller name).">
		<cfargument name="modelVariable" type="string" default="#arguments.modelName#" hint="I am the name of the variable used to store the controller's default model (defaults to the model name).">
		<cfargument name="modelDisplayName" type="string" default="#Humanize(arguments.modelName)#" hint="I am the display name of the controller's default model (defaults to the model name).">
		<cfargument name="afterCreateKey" type="string" default="" hint="I am the location of a key to be used after a successful create (defaults to blank).">
		<cfargument name="afterCreateController" type="string" default="#variables.$class.name#" hint="I am the controller to redirect to after a successful create (defaults to current controller).">
		<cfargument name="afterCreateAction" type="string" default="index" hint="I am the action to redirect to after a successful create (defaults to 'index').">
		<cfargument name="afterCreateRoute" type="string" default="" hint="I am an optional route to redirect to after a successful create (defaults to blank).">
		<cfargument name="afterCreateMessage" type="string" default="[modelDisplayName] has been successfully created." hint="I am an optional message to store in the flash after a successful create.">
		<cfargument name="afterUpdateKey" type="string" default="" hint="I am the location of a key to be used after a successful update (defaults to blank).">
		<cfargument name="afterUpdateController" type="string" default="#variables.$class.name#" hint="I am the controller to redirect to after a successful update (defaults to current controller).">
		<cfargument name="afterUpdateAction" type="string" default="index" hint="I am the action to redirect to after a successful update (defaults to 'index').">
		<cfargument name="afterUpdateRoute" type="string" default="" hint="I am am optional route to redirect to after a successful update (defaults to blank).">
		<cfargument name="afterUpdateMessage" type="string" default="[modelDisplayName] has been successfully updated." hint="I am an optional message to store in the flash after a successful update.">
		<cfargument name="afterDeleteKey" type="string" default="" hint="I am the location of a key to be used after a successful delete (defaults to blank).">
		<cfargument name="afterDeleteController" type="string" default="#variables.$class.name#" hint="I am the controller to redirect to after a successful delete (defaults to the current controller).">
		<cfargument name="afterDeleteAction" type="string" default="index" hint="I am the action to redirect to after a successful delete (defaults to 'index').">
		<cfargument name="afterDeleteRoute" type="string" default="" hint="I am an optional route to redirect to after a successful delete (defaults to blank).">
		<cfargument name="afterDeleteMessage" type="string" default="[modelDisplayName] has been successfully deleted." hint="I am an optional message to store in the flash after a successful delete.">
		<cfargument name="failedDeleteMessage" type="string" default="[modelDisplayName] could not be deleted." hint="I am an optional message to store in the flash after a failed delete.">
		<cfargument name="controllerParams" type="string" default="" hint="I am a comma delimited list of params to be excluded when automatically populating the controller's default model from the params struct.">
		<cfset variables.$class.autoController = Duplicate(arguments)>
		<cfset variables.$class.autoController.controllerParams = ListAppend(variables.$class.autoController.controllerParams, "route,controller,action,key")>
	</cffunction>
	
	
	
	<!--- ACCESSORS FOR EASIER CONFIGUATION --->
	
	<cffunction name="modelName" returntype="void" access="public" mixin="controller">
		<cfargument name="modelName" type="string" required="true">
		<cfset variables.$class.autoController.modelName = arguments.modelName>
	</cffunction>
	
	<cffunction name="modelVariable" returntype="void" access="public" mixin="controller">
		<cfargument name="modelVariable" type="string" required="true">
		<cfset variables.$class.autoController.modelVariable = arguments.modelVariable>
	</cffunction>

	<cffunction name="modelDisplayName" returntype="void" access="public" mixin="controller">
		<cfargument name="modelDisplayName" type="string" required="true">
		<cfset variables.$class.autoController.modelDisplayName = arguments.modelDisplayName>
	</cffunction>

	<cffunction name="afterCreateKey" returntype="void" access="public" mixin="controller">
		<cfargument name="afterCreateKey" type="string" required="true">
		<cfset variables.$class.autoController.afterCreateKey = arguments.afterCreateKey>
	</cffunction>

	<cffunction name="afterCreateController" returntype="void" access="public" mixin="controller">
		<cfargument name="afterCreateController" type="string" required="true">
		<cfset variables.$class.autoController.afterCreateController = arguments.afterCreateController>
	</cffunction>

	<cffunction name="afterCreateAction" returntype="void" access="public" mixin="controller">
		<cfargument name="afterCreateAction" type="string" required="true">
		<cfset variables.$class.autoController.afterCreateAction = arguments.afterCreateAction>
	</cffunction>

	<cffunction name="afterCreateRoute" returntype="void" access="public" mixin="controller">
		<cfargument name="afterCreateRoute" type="string" required="true">
		<cfset variables.$class.autoController.afterCreateRoute = arguments.afterCreateRoute>
	</cffunction>

	<cffunction name="afterUpdateKey" returntype="void" access="public" mixin="controller">
		<cfargument name="afterUpdateKey" type="string" required="true">
		<cfset variables.$class.autoController.afterUpdateKey = arguments.afterUpdateKey>
	</cffunction>

	<cffunction name="afterUpdateController" returntype="void" access="public" mixin="controller">
		<cfargument name="afterUpdateController" type="string" required="true">
		<cfset variables.$class.autoController.afterUpdateController = arguments.afterUpdateController>
	</cffunction>

	<cffunction name="afterUpdateAction" returntype="void" access="public" mixin="controller">
		<cfargument name="afterUpdateAction" type="string" required="true">
		<cfset variables.$class.autoController.afterUpdateAction = arguments.afterUpdateAction>
	</cffunction>

	<cffunction name="afterUpdateRoute" returntype="void" access="public" mixin="controller">
		<cfargument name="afterUpdateRoute" type="string" required="true">
		<cfset variables.$class.autoController.afterUpdateRoute = arguments.afterUpdateRoute>
	</cffunction>

	<cffunction name="afterDeleteKey" returntype="void" access="public" mixin="controller">
		<cfargument name="afterDeleteKey" type="string" required="true">
		<cfset variables.$class.autoController.afterDeleteKey = arguments.afterDeleteKey>
	</cffunction>

	<cffunction name="afterDeleteController" returntype="void" access="public" mixin="controller">
		<cfargument name="afterDeleteController" type="string" required="true">
		<cfset variables.$class.autoController.afterDeleteController = arguments.afterDeleteController>
	</cffunction>

	<cffunction name="afterDeleteAction" returntype="void" access="public" mixin="controller">
		<cfargument name="afterDeleteAction" type="string" required="true">
		<cfset variables.$class.autoController.afterDeleteAction = arguments.afterDeleteAction>
	</cffunction>

	<cffunction name="afterDeleteRoute" returntype="void" access="public" mixin="controller">
		<cfargument name="afterDeleteRoute" type="string" required="true">
		<cfset variables.$class.autoController.afterDeleteRoute = arguments.afterDeleteRoute>
	</cffunction>

	<cffunction name="controllerParams" returntype="void" access="public" mixin="controller">
		<cfargument name="controllerParams" type="string" required="true">
		<cfset variables.$class.autoController.controllerParams = ListAppend(variables.$class.autoController.controllerParams, arguments.controllerParams)>
	</cffunction>

	

	<!--- AUTOMATED CONTROLLER ACTIONS --->

	<cffunction name="index" mixin="controller">
		<cfargument name="modelName" type="string" default="#variables.$class.autoController.modelName#" hint="I am the name of the action's model (defaults to the controller's default model name).">
		<cfargument name="modelVariable" type="string" default="#arguments.modelName#" hint="I am the name of the variable used to store the action's default model (defaults to the actions model name).">
		<cfargument name="modelDisplayName" type="string" default="#Humanize(arguments.modelName)#" hint="I am the display name of the action's default model (defaults to the humanized action's model name).">
		<cfargument name="template" type="string" default="index" hint="I am the name of this action's template file.">
		<cfset variables.$autoController = Duplicate(arguments)>
		<cfset variables[Pluralize(arguments.modelVariable)] = model(arguments.modelName).findAll()>
		<cfset renderPage(template=arguments.template)>
	</cffunction>


	<cffunction name="new" mixin="controller">
		<cfargument name="modelName" type="string" default="#variables.$class.autoController.modelName#" hint="I am the name of the action's model (defaults to the controller's default model name).">
		<cfargument name="modelVariable" type="string" default="#variables.$class.autoController.modelVariable#" hint="I am the name of the variable used to store the action's default model (defaults to the actions model name).">
		<cfargument name="modelDisplayName" type="string" default="#Humanize(arguments.modelName)#" hint="I am the display name of the action's default model (defaults to the humanized action's model name).">
		<cfargument name="afterCreateKey" type="string" default="#variables.$class.autoController.afterCreateKey#" hint="I am the location of a key to be used after a successful create (defaults to blank).">
		<cfargument name="afterCreateController" type="string" default="#variables.$class.autoController.afterCreateController#" hint="I am the controller to redirect to after a successful create (defaults to current controller).">
		<cfargument name="afterCreateAction" type="string" default="#variables.$class.autoController.afterCreateAction#" hint="I am the action to redirect to after a successful create (defaults to 'index').">
		<cfargument name="afterCreateRoute" type="string" default="#variables.$class.autoController.afterCreateRoute#" hint="I am an optional route to redirect to after a successful create (defaults to blank).">
		<cfargument name="afterCreateMessage" type="string" default="#variables.$class.autoController.afterCreateMessage#" hint="I am an optional message to store in the flash after a successful create.">
		<cfargument name="template" type="string" default="edit" hint="I am the name of this action's template file.">
		<cfset variables.$autoController = Duplicate(arguments)>
		<cfif StructKeyExists(params, arguments.modelVariable)>
			<cfset variables[arguments.modelVariable] = model(arguments.modelName).new(params[arguments.modelVariable])>
			<cfif variables[arguments.modelVariable].save()>
				<cfif Len(arguments.afterCreateMessage)>
					<cfset flashInsert(success=Replace(arguments.afterCreateMessage, "[modelDisplayName]", Humanize(arguments.modelName), "all"))>
				</cfif>
				<cfset arguments.actionType = "create">
				<cfset redirectTo(argumentCollection=$getRedirectArguments(argumentCollection=arguments))>
			</cfif>
		<cfelse>
			<cfset variables[arguments.modelVariable] = model(arguments.modelName).new($cleanUpParams(variables.params))>
		</cfif>
		<cfset renderPage(argumentCollection=arguments)>
	</cffunction>
	

	<cffunction name="edit" mixin="controller">
		<cfargument name="modelName" type="string" default="#variables.$class.autoController.modelName#" hint="I am the name of the action's model (defaults to the controller's default model name).">
		<cfargument name="modelVariable" type="string" default="#variables.$class.autoController.modelVariable#" hint="I am the name of the variable used to store the action's default model (defaults to the actions model name).">
		<cfargument name="modelDisplayName" type="string" default="#Humanize(arguments.modelName)#" hint="I am the display name of the action's default model (defaults to the humanized action's model name).">
		<cfargument name="afterUpdateKey" type="string" default="#variables.$class.autoController.afterCreateKey#" hint="I am the location of a key to be used after a successful update (defaults to blank).">
		<cfargument name="afterUpdateController" type="string" default="#variables.$class.autoController.afterUpdateController#" hint="I am the controller to redirect to after a successful update (defaults to current controller).">
		<cfargument name="afterUpdateAction" type="string" default="#variables.$class.autoController.afterUpdateAction#" hint="I am the action to redirect to after a successful update (defaults to 'index').">
		<cfargument name="afterUpdateRoute" type="string" default="#variables.$class.autoController.afterUpdateRoute#" hint="I am an optional route to redirect to after a successful update (defaults to blank).">
		<cfargument name="afterUpdateMessage" type="string" default="#variables.$class.autoController.afterUpdateMessage#" hint="I am an optional message to store in the flash after a successful update.">
		<cfset variables.$autoController = Duplicate(arguments)>
		<cfset variables[arguments.modelVariable] = loadModel(argumentCollection=arguments)>
		<cfif IsObject(variables[arguments.modelVariable]) and StructKeyExists(params, arguments.modelVariable) and variables[arguments.modelVariable].update(properties=params[arguments.modelVariable])>
			<cfif Len(arguments.afterUpdateMessage)>
				<cfset flashInsert(success=Replace(arguments.afterUpdateMessage, "[modelDisplayName]", Humanize(arguments.modelName), "all"))>
			</cfif>
			<cfset arguments.actionType = "update">
			<cfset redirectTo(argumentCollection=$getRedirectArguments(argumentCollection=arguments))>
		</cfif>
		<cfset renderPage(argumentCollection=arguments)>
	</cffunction>
	

	<cffunction name="delete" mixin="controller">
		<cfargument name="modelName" type="string" default="#variables.$class.autoController.modelName#" hint="I am the name of the action's model (defaults to the controller's default model name).">
		<cfargument name="modelVariable" type="string" default="#arguments.modelName#" hint="I am the name of the variable used to store the action's default model (defaults to the actions model name).">
		<cfargument name="modelDisplayName" type="string" default="#Humanize(arguments.modelName)#" hint="I am the display name of the action's default model (defaults to the humanized action's model name).">
		<cfargument name="afterDeleteKey" type="string" default="#variables.$class.autoController.afterDeleteKey#" hint="I am the location of a key to be used after a successful delete (defaults to blank).">
		<cfargument name="afterDeleteController" type="string" default="#variables.$class.autoController.afterDeleteController#" hint="I am the controller to redirect to after a successful delete (defaults to current controller).">
		<cfargument name="afterDeleteAction" type="string" default="#variables.$class.autoController.afterDeleteAction#" hint="I am the action to redirect to after a successful delete (defaults to 'index').">
		<cfargument name="afterDeleteRoute" type="string" default="#variables.$class.autoController.afterDeleteRoute#" hint="I am an optional route to redirect to after a successful delete (defaults to blank).">
		<cfargument name="afterDeleteMessage" type="string" default="#variables.$class.autoController.afterDeleteMessage#" hint="I am an optional message to store in the flash after a successful delete.">
		<cfargument name="failedDeleteMessage" type="string" default="#variables.$class.autoController.failedDeleteMessage#" hint="I am an optional message to store in the flash if a delete is unsuccessful.">
		<cfset variables.$autoController = Duplicate(arguments)>
		<cfset variables[arguments.modelVariable] = loadModel(argumentCollection=arguments)>
		<cfif IsObject(variables[arguments.modelVariable]) and variables[arguments.modelVariable].delete()>
			<cfif Len(arguments.afterDeleteMessage)>
				<cfset flashInsert(success=Replace(arguments.afterDeleteMessage, "[modelDisplayName]", Humanize(arguments.modelName), "all"))>
			</cfif>
		<cfelse>	
			<cfif Len(arguments.failedDeleteMessage)>
				<cfset flashInsert(error=Replace(arguments.failedDeleteMessage, "[modelDisplayName]", Humanize(arguments.modelName), "all"))>
			</cfif>
		</cfif>
		<cfset arguments.actionType = "delete">
		<cfset redirectTo(argumentCollection=$getRedirectArguments(argumentCollection=arguments))>
	</cffunction>

	
	
	<!--- HELPERS --->
	
	<cffunction name="loadModel" returntype="any" output="false" mixin="controller">
		<cfargument name="modelName" type="string" default="#variables.$class.autoController.modelName#" hint="I am the name of the model (defaults to the controller's default model name).">
		<cfif StructKeyExists(variables.params, "key")>
			<cfset arguments.key = variables.params.key>
			<cfreturn model(arguments.modelName).findByKey(argumentCollection=arguments)>
		</cfif>
		<cfreturn false>
	</cffunction>


	<cffunction name="startFormTag" returntype="string" output="false" mixin="controller">
		<cfargument name="action" type="string" default="">
		<cfargument name="key" type="string" default="">
		<cfset var coreFunction = core.startFormTag>
		<cfif StructKeyExists(variables, "$autoController") and StructKeyExists(variables, variables.$autoController.modelVariable) and IsObject(variables[variables.$autoController.modelVariable])>
			<cfif not Len(arguments.action)>
				<cfset arguments.action = variables.params.action>
			</cfif>
			<cfif not Len(arguments.key) and not variables[variables.$autoController.modelVariable].isNew()>
				<cfset arguments.key = variables[variables.$autoController.modelVariable].key()>
			</cfif>
		</cfif>
		<cfreturn coreFunction(argumentCollection=arguments)>
	</cffunction>
	
	
	<!--- PRIVATE METHODS --->

	<cffunction name="$getRedirectArguments" returntype="struct" output="false" mixin="controller">
		<cfargument name="actionType" type="string" required="true">
		<cfargument name="afterCreateKey" type="string" default="">
		<cfargument name="afterCreateController" type="string" default="">
		<cfargument name="afterCreateAction" type="string" default="">
		<cfargument name="afterCreateRoute" type="string" default="">
		<cfargument name="afterUpdateKey" type="string" default="">
		<cfargument name="afterUpdateController" type="string" default="">
		<cfargument name="afterUpdateAction" type="string" default="">
		<cfargument name="afterUpdateRoute" type="string" default="">
		<cfargument name="afterDeleteKey" type="string" default="">
		<cfargument name="afterDeleteController" type="string" default="">
		<cfargument name="afterDeleteAction" type="string" default="">
		<cfargument name="afterDeleteRoute" type="string" default="">

		<cfset var redirectArgs = StructNew()>
		
		<cfswitch expression="#arguments.actionType#">
			<cfcase value="create">
				<cfif Len(arguments.afterCreateRoute)>
					<cfset redirectArgs.route = arguments.afterCreateRoute>
				<cfelse>
					<cfset redirectArgs.controller = arguments.afterCreateController>
					<cfset redirectArgs.action = arguments.afterCreateAction>
				</cfif>
				<cfif Len(arguments.afterCreateKey) and IsDefined(arguments.afterCreateKey)>
					<cfset redirectArgs.key = Evaluate(arguments.afterCreateKey)>
				</cfif>
			</cfcase>
			<cfcase value="update">
				<cfif Len(arguments.afterUpdateRoute)>
					<cfset redirectArgs.route = arguments.afterUpdateRoute>
				<cfelse>
					<cfset redirectArgs.controller = arguments.afterUpdateController>
					<cfset redirectArgs.action = arguments.afterUpdateAction>
				</cfif>
				<cfif Len(arguments.afterUpdateKey) and IsDefined(arguments.afterUpdateKey)>
					<cfset redirectArgs.key = Evaluate(arguments.afterUpdateKey)>
				</cfif>
			</cfcase>
			<cfcase value="delete">
				<cfif Len(arguments.afterDeleteRoute)>
					<cfset redirectArgs.route = arguments.afterDeleteRoute>
				<cfelse>
					<cfset redirectArgs.controller = arguments.afterDeleteController>
					<cfset redirectArgs.action = arguments.afterDeleteAction>
				</cfif>
				<cfif Len(arguments.afterDeleteKey) and IsDefined(arguments.afterDeleteKey)>
					<cfset redirectArgs.key = Evaluate(arguments.afterDeleteKey)>
				</cfif>
			</cfcase>
		</cfswitch>
		
		<cfreturn redirectArgs>
	</cffunction>


	<cffunction name="$cleanUpParams" returntype="struct" output="false" mixin="controller">
		<cfargument name="params" type="struct" required="true">
		<cfset var newParams = Duplicate(arguments.params)>
		<cfset var param = "">
		<cfloop list="#variables.$class.autoController.controllerParams#" index="param">
			<cfset StructDelete(newParams, param)>
		</cfloop>
		<cfreturn newParams>
	</cffunction>
	

</cfcomponent>