import { LightningElement,wire } from 'lwc';

import {publish,MessageContext} from 'lightning/messageService';
import dataChannel from '@salesforce/messageChannel/dataChannel__c';

export default class PublisherLWC extends LightningElement {

@wire(MessageContext)
messageContext;

handlePublish(){
    let num = Number(Math.random()*100).toFixed(0)
    publish(this.messageContext,dataChannel,{recordId:'test'+num});
}

}