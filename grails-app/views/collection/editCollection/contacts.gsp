<%@ page import="au.org.ala.collectory.Contact; au.org.ala.collectory.CollectionCommand" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'collection.label', default: 'Collection')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
          <h1>Editing: ${fieldValue(bean: command, field: "name")}</h1>
        </div>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${command}">
            <div class="errors">
                <g:renderErrors bean="${command}" as="list" />
            </div>
            </g:hasErrors>
            <g:hasErrors bean="${contact}">
            <div class="errors">
                <g:renderErrors bean="${contact}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" action="editCollection">
                <g:hiddenField name="id" value="${command?.id}" />
                <!-- event field is used by submit buttons to pass the web flow event (rather than using the text of the button as the event name) -->
                <g:hiddenField id="event" name="_eventId" value="next" />
                <g:hiddenField id="idToRemove" name="idToRemove" value="" />
                <cl:navButtons exclude="next"/>
                <div class="dialog">
                  <p class="wizardHeading">Choose contacts for this collection</p>

                    <span style="margin-left:50px;"><g:message code="providerGroup.existingContacts.label" default="Current contacts for this collection" /></span>
                    <img style="float:right;margin-right:20px;" class="helpButton" alt="help" src="${resource(dir:'images/skin', file:'help.gif')}"
                            onclick="toggleRow('currentContacts')"/>
                  
                    <table class="value">
                      <colgroup><col width="30%"/><col width="40%"/><col width="10%"/><col width="10%"/><col width="10%"/></colgroup>
                      <thead><th>Name</th><th>Role (for this collection)</th><th>Edit?</th><th>Primary</th><th></th></thead>
                      <tbody>
<!-- current -->          <g:each in="${command.contacts}" var="i" status="row">
                            <g:hiddenField name="contactId" value="${i?.id}"/>
                            <tr class="prop">
                              <td style="vertical-align:middle;">${i?.contact?.buildName()}</td>
                              <td valign="top" class="value"><g:textField name="role_${i.id}" value="${i?.role}"/></td>
                              <td valign="top" class="name">
                                <g:checkBox style="margin-left:7px;" name="admin_${i.id}" value="${i?.administrator}"/>
                              </td>
                              <td valign="top" class="name">
                                <g:checkBox style="margin-left:7px;" name="primary_${i.id}" value="${i?.primaryContact}"/>
                              </td>
                              <td valign="baseline" style="width:130px;vertical-align:middle">
                                <span class="bodyButton"><input type="submit" style="color:#222" class="remove" value="Remove"
                                  onclick="document.getElementById('event').value = 'remove';document.getElementById('idToRemove').value = '${i?.id}';return confirm('Remove ${i?.contact?.buildName()} as a contact for this collection?');"/>
                                </span>
                              </td>
                            </tr>
                          </g:each>
                          <tr><td colspan="5"><div id="currentContacts" class="fieldHelp" style="display:none"><g:message code="collection.contacts" /></div></td></tr>
                        </tbody>
                    </table>

<!--add existing--> <span style="margin-left:50px;"><g:message code="providerGroup.addAContact.label" default="Add a known contact to this collection" /></span>

                    <img style="float:right;margin-right:20px;" class="helpButton" alt="help" src="${resource(dir:'images/skin', file:'help.gif')}"
                          onclick="toggleRow('addExistingContact')"/>
                    <table class="value">
                      <colgroup><col width="28%"/><col width="62%"/><col width="10%"/></colgroup>

                      <tr class="prop">
                        <td valign="top" class="name">Select</td>
                        <td valign="top" class="value">
                          <g:select name="addContact" from="${Contact.listOrderByLastName()}" optionKey="id" noSelection="${['null':'Select one to add']}" />
                        </td>
<!-- add button -->     <td>
                          <input type="submit" onclick="return anySelected('addContact','You must select a contact to add.');" class="addAction" value="Add contact"/>
                        </td>
                      </tr>
                      <tr><td colspan="3"><div id="addExistingContact" class="fieldHelp" style="display:none"><g:message code="collection.addExistingContact" /></div></td></tr>

                    </table>

<!-- add new -->      <span style="margin-left:50px;">Create a new contact and add to this collection</span>
                      <img style="float:right;margin-right:20px;" class="helpButton" alt="help" src="${resource(dir:'images/skin', file:'help.gif')}"
                        onclick="toggleRow('addNewContact')"/>
                      <table class="value">

<!-- title-->           <tr class="prop">
                          <td valign="top" class="name">
                            <label for="title"><g:message code="contact.title.label" default="Title" /></label><br/>
                            <span style="color:#777">e.g. Dr</span>
                          </td>
                          <td valign="top" class="value ${hasErrors(bean: contact, field: 'title', 'errors')}">
                              <g:textField name="title" maxlength="10" value="${fieldValue(bean: contact, field:'title')}"/>
                          </td>
                        </tr>

<!-- firstName-->       <tr class="prop">
                          <td valign="top" class="name">
                            <label for="firstName"><g:message code="contact.firstName.label" default="First name" /></label>
                          </td>
                          <td valign="top" class="value ${hasErrors(bean: contact, field: 'firstName', 'errors')}">
                              <g:textField name="firstName" maxlength="255" value="${fieldValue(bean: contact, field:'firstName')}"/>
                          </td>
                        </tr>

<!-- lastName-->        <tr class="prop">
                          <td valign="top" class="name">
                            <label for="lastName"><g:message code="contact.lastName.label" default="Last name" /></label>
                          </td>
                          <td valign="top" class="value ${hasErrors(bean: contact, field: 'lastName', 'errors')}">
                              <g:textField name="lastName" maxlength="255" value="${fieldValue(bean: contact, field:'lastName')}"/>
                          </td>
                        </tr>

<!-- phone-->           <tr class="prop">
                          <td valign="top" class="name">
                            <label for="phone"><g:message code="contact.phone.label" default="Phone" /></label>
                          </td>
                          <td valign="top" class="value ${hasErrors(bean: contact, field: 'phone', 'errors')}">
                              <g:textField name="phone" maxlength="45" value="${fieldValue(bean: contact, field:'phone')}"/>
                          </td>
                        </tr>

<!-- mobile-->          <tr class="prop">
                          <td valign="top" class="name">
                            <label for="mobile"><g:message code="contact.mobile.label" default="Mobile" /></label>
                          </td>
                          <td valign="top" class="value ${hasErrors(bean: contact, field: 'mobile', 'errors')}">
                              <g:textField name="mobile" maxlength="45" value="${fieldValue(bean: contact, field:'mobile')}"/>
                          </td>
                        </tr>

<!-- email-->           <tr class="prop">
                          <td valign="top" class="name">
                            <label for="email"><g:message code="contact.email.label" default="Email" /></label>
                          </td>
                          <td valign="top" class="value ${hasErrors(bean: contact, field: 'email', 'errors')}">
                              <g:textField name="email" maxlength="45" value="${fieldValue(bean: contact, field:'email')}"/>
                          </td>
                        </tr>

<!-- fax-->             <tr class="prop">
                          <td valign="top" class="name">
                            <label for="fax"><g:message code="contact.fax.label" default="Fax" /></label>
                          </td>
                          <td valign="top" class="value ${hasErrors(bean: command, field: 'fax', 'errors')}">
                              <g:textField name="fax" maxlength="45" value="${fieldValue(bean: contact, field:'fax')}"/>
                          </td>
                        </tr>

<!-- notes-->           <tr class="prop">
                          <td valign="top" class="name">
                            <label for="notes"><g:message code="contact.notes.label" default="Notes" /></label>
                          </td>
                          <td valign="top" class="value ${hasErrors(bean: contact, field: 'notes', 'errors')}">
                              <g:textArea name="notes" cols="40" rows="5" maxlength="1024" value="${fieldValue(bean: contact, field:'notes')}"/>
                          </td>
                        </tr>

<!-- publish-->         <tr class="prop">
                          <td class="checkbox">
                            <label for="publish"><g:message code="contact.publish.label" default="Make public?" /></label>
                          </td>
                          <td class="checkbox">
                              <label>
                                <g:checkBox name="publish" value="true"/>
                                <span class="hint">Contact will be shown on the collection page</span>
                              </label>
                          </td>
                        </tr>

                        <tr><td>
                          <input type="submit" onclick="return document.getElementById('event').value = 'create'" class="addAction" value="Add contact"/>
                        </td></tr>

                        <tr><td colspan="2"><div id="addNewContact" class="fieldHelp" style="display:none"><g:message code="collection.addNewContact" /></div></td></tr>
                    </table>
                </div>
            </g:form>
        </div>
    </body>
</html>
