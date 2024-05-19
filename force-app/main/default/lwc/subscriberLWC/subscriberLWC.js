import { LightningElement, wire } from 'lwc';
import {subscribe,MessageContext} from 'lightning/messageService';

import dataChannel from '@salesforce/messageChannel/dataChannel__c'

export default class SubscriberLWC extends LightningElement {
    @wire(MessageContext)
    messageContext;

    message = '';

    connectedCallback(){
        subscribe(this.messageContext,dataChannel,(mesg)=>{
            console.log(JSON.stringify(mesg));

            this.message = mesg;
        });
    }
}