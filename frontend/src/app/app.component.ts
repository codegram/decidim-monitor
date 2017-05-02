import { Apollo } from "apollo-angular";
import { Component, OnInit } from '@angular/core';
import gql from "graphql-tag";

const query = gql`
{
  installations {
    url
    version
  }
}
`

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

  constructor(private apollo: Apollo) {
  }

  ngOnInit() {
    this.apollo.watchQuery<QueryResponse>({ query, pollInterval: 10000 })
      .subscribe(({ data }) => this.installations = data.installations);
  }
}
