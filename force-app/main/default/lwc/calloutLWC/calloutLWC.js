import { LightningElement, track } from 'lwc';
import callout1 from '@salesforce/apex/CalloutLWC.callout1';
import callout2 from '@salesforce/apex/CalloutLWC.callout2';


export default class CalloutLWC extends LightningElement {

    async connectedCallback(){
       let c1 = await callout1();
       let c2 = await callout2({parameter1:c1});
       console.log('C2 ',c2);
    }


}