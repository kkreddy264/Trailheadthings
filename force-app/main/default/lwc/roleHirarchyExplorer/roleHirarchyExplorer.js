import { LightningElement, api } from 'lwc';
import getAllRoleHirarchy from '@salesforce/apex/HierarchyController.getAllRoleHirarchy';
import getAllAccountHirarchy from '@salesforce/apex/HierarchyController.getAllAccountHirarchy';
const COLUMNS_DEFINITION_BASIC = [
    {
        type: 'text',
        fieldName: 'Name',
        label: 'Role Name',
    },
    {
        type: 'text',
        fieldName: 'Id',
        label: 'Role Id',
    },
];
export default class RoleHirarchyExplorer extends LightningElement {
    hierarchyMap;
    hierarchyAccMap;

    //pass your columns definition as per your requirement
    @api gridColumns = COLUMNS_DEFINITION_BASIC;

    //This is the field api name of field whose value will be put in parent field of child
    //for example UserRole, Id of the parent role will be the ParentRoleId field value of child role
    @api primaryKey = 'Id';

    connectedCallback() {
        getAllRoleHirarchy().then(result => {
            this.parseResult(result);
        }).catch(error => {
            console.log('error', error, JSON.stringify(error));
        });
        getAllAccountHirarchy().then(result=>{
            this.hierarchyAccMap = result;
        }).catch(error=>{
            console.log('error', error, JSON.stringify(error));
        });
    }

    parseResult(result) {
        this.hierarchyMap = [];
        result.superParentList.forEach(element => {
            this.hierarchyMap.push(this.findChildrenNode(element, result));
        });
        this.hierarchyMap = JSON.parse(JSON.stringify(this.hierarchyMap));
    }

    findChildrenNode(element, result) {
        for (var key in result.parentMap) {
            if (key == element[this.primaryKey]) {
                element["_children"] = result.parentMap[key];
                element["_children"].forEach(child => {
                    this.findChildrenNode(child, result);
                });
            }
        }
        return element;
    }
}