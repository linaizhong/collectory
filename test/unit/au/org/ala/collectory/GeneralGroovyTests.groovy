package au.org.ala.collectory

import grails.test.GrailsUnitTestCase

/**
 * Created by markew
 * Date: May 20, 2010
 * Time: 11:31:48 AM
 */
class GeneralGroovyTests extends GrailsUnitTestCase {

    void testListFilter() {
        def list = []
        list << new ProviderGroup(guid: 1, name: "1", groupType: ProviderGroup.GROUP_TYPE_COLLECTION)
        list << new ProviderGroup(guid: 2, name: "2", groupType: ProviderGroup.GROUP_TYPE_COLLECTION)
        list << new ProviderGroup(guid: 3, name: "3", groupType: ProviderGroup.GROUP_TYPE_INSTITUTION)
        list << new ProviderGroup(guid: 4, name: "4", groupType: ProviderGroup.GROUP_TYPE_INSTITUTION)
        list << new ProviderGroup(guid: 5, name: "5", groupType: ProviderGroup.GROUP_TYPE_COLLECTION)

        assertEquals 2, list.findAll{it.groupType == ProviderGroup.GROUP_TYPE_INSTITUTION}.size()
    }

    void testLoadingAsParams() {
        String [] keys = ['one', 'two', 'three'];
        def values = ['v1', 'v2', 'v3']
        def params = [:]
        keys.eachWithIndex {it, i ->
            params[it] = values[i]
        }
        assertEquals 3, params.size()
        params.each {key, value ->
            println "${key} == ${value}"
        }
        assertEquals 'v2', params.two
    }


}
