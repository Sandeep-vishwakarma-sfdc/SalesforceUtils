import { LightningElement, track,wire } from 'lwc';
import getAccountsWithContacts from '@salesforce/apex/AcoountTreeGrid.getAccountsWithContacts';
import loadMoreLineItems from '@salesforce/apex/AcoountTreeGrid.loadMoreLineItems';

export default class TreeGridLWCExample extends LightningElement {
    @track accounts = [];

    @wire(getAccountsWithContacts)
    wiredAccounts({ error, data }) {
        console.log('Data ',data);
        if (data) {
            this.accounts = Object.keys(data).map(accountId => ({
                id: accountId,
                name: data[accountId][0].Account.Name,
                items: data[accountId],
                showItems: false,
                hasMoreItems: data[accountId].length === 10,
                offset: 10
            }));
        } else if (error) {
            console.error(error);
        }
    }

    handleAccountClick(event) {
        const accountId = event.currentTarget.dataset.id;
        this.accounts = this.accounts.map(account => ({
            ...account,
            showItems: account.id === accountId ? !account.showItems : false
        }));
    }

    handleLoadMore(event) {
        event.preventDefault();
        const accountId = event.currentTarget.dataset.id;
        const account = this.accounts.find(acc => acc.id === accountId);

        loadMoreLineItems({ accountId:accountId, offset: account.offset })
            .then(moreItems => {
                this.accounts = this.accounts.map(acc => {
                    if (acc.id === accountId) {
                        return {
                            ...acc,
                            items: [...acc.items, ...moreItems],
                            hasMoreItems: moreItems.length === 10,
                            offset: acc.offset + 10
                        };
                    }
                    return acc;
                });
            })
            .catch(error => {
                console.error(error);
            });
    }
}