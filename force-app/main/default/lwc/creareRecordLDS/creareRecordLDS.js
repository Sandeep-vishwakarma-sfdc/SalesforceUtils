import { LightningElement, wire } from 'lwc';
import {createRecord,getRecord} from 'lightning/uiRecordApi'
import ACOUNT_NAME_FIELD from '@salesforce/schema/Account.Name'
const FIELDS = ['Account.Name','Account.Rating'];
export default class CreareRecordLDS extends LightningElement {

    @wire(getRecord, {recordId:'$recordId',fields:FIELDS})
    wireAccount({error, data}) {
        if (error) {
            // TODO: Error handling
        } else if (data) {
            // TODO: Data handling
        }
    }

    connectedCallback(){
        let fields = {};
        fields[ACOUNT_NAME_FIELD] = 'Test';
        let recordInput = {apiName:'Account',fields}
        createRecord(recordInput).then(data=>{
            console.log(data.Id);
        }).catch(error=>console.log(error))
    }

}