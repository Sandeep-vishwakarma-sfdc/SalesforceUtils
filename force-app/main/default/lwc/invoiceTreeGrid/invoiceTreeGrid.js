import { LightningElement,track,wire } from 'lwc';
import getInvoicesWithLineItems from '@salesforce/apex/InvoiceController.getInvoicesWithLineItems';
import loadMoreLineItems from '@salesforce/apex/InvoiceController.loadMoreLineItems';

export default class InvoiceTreeGrid extends LightningElement {
    @track gridData = [];
    @track isLoading = false;
    @track currentExpanded = [];

    gridColumns = [
        { label: 'Name', fieldName: 'name' }
    ];

    @wire(getInvoicesWithLineItems)
    wiredInvoices({ error, data }) {
        if (data) {
            this.gridData = data.map(invoice => ({
                id: invoice.id,
                name: invoice.name,
                _children: invoice.lineItems,
                hasMoreItems: invoice.lineItems.length === 10,
                toggleOn:false,
                offset: 10
            }));
            console.log('Data ',this.gridData);
        } else if (error) {
            console.error(error);
        }
    }

    handleAction(event){
        console.log('event ',JSON.stringify(event));
        if(this.currentExpanded.includes(event.detail.row.id)){
            this.currentExpanded = [];
        }else{
        this.currentExpanded = [event.detail.row.id];
        }
        
    }

    handleToggle(event){
        let invoiceId = event.currentTarget.dataset.id;
        console.log('invoice Id ',invoiceId);
        let dataIndex = this.gridData.findIndex(ele=>ele.id==invoiceId);
        if(this.currentExpanded.includes(invoiceId)){
            this.gridData[dataIndex].toggleOn = false;
            this.currentExpanded = [];
        }else{
            this.gridData[dataIndex].toggleOn = true;
            this.currentExpanded = [invoiceId];
        }
        let data = this.gridData.forEach(ele=>{
            if(ele.id!=invoiceId){
                ele.toggleOn = false;
            }
        })
        this.gridData = [...data];
    }

    handleLoadMore(event) {
        // const row = event.detail.row;
        console.log('Test');
        const invoiceId = event.currentTarget.dataset.id;
        console.log('invoice Id ',invoiceId);
        const index = this.gridData.findIndex(ele=>ele.id==invoiceId);
        let row = this.gridData[index];

        

        console.log('row ',row);
        if (row.hasMoreItems) {
            this.isLoading = true;
            loadMoreLineItems({ invoiceId: row.id, offset: row.offset })
                .then(moreItems => {
                    const invoice = this.gridData.find(inv => inv.id === row.id);
                    invoice._children = [...invoice._children, ...moreItems];
                    invoice.hasMoreItems = moreItems.length === 10;
                    invoice.offset += 10;
                    this.gridData = [...this.gridData];
                })
                .catch(error => {
                    console.error(error);
                })
                .finally(() => {
                    this.isLoading = false;
                });
        }
    }
    handleRowSelection(event){
        console.log('event 1',JSON.stringify(event));
    }
}