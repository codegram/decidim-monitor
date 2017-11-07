import { Apollo } from 'apollo-angular';
import { map } from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import gql from 'graphql-tag';

const query = gql`
{
  installations {
    name
    url
    repo
    version
    codegram
  }
}
`;

interface QueryResponse {
  installations: Array<any>;
  loading: boolean;
}

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit {
  title = 'app works!';
  installations: Array<{ url: string, version: string }>;
  loading: Boolean;

  constructor(private apollo: Apollo) {
  }

  ngOnInit() {
    this.loading = true;
    this.apollo.watchQuery<QueryResponse>({ query, pollInterval: 10000 })
      .pipe(
        map(({ data }) => data.installations),
        map(installations => installations.concat().sort((a, b) => a.name < b.name ? -1 : 1))
      ).subscribe(installations => { this.installations = installations; this.loading = false; });
  }
}
