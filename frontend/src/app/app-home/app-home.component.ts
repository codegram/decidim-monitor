import { Apollo } from "apollo-angular";
import { map } from "rxjs/operators";
import { Component, OnInit } from "@angular/core";
import gql from "graphql-tag";

const query = gql`
  {
    installations {
      name
      url
      repo
      version
      codegram
    }

    decidim {
      version
    }
  }
`;

interface QueryResponse {
  installations: Array<any>;
  loading: boolean;
  decidim: { version: string };
}

@Component({
  selector: "app-home",
  templateUrl: "./app-home.component.html"
})
export class AppHome implements OnInit {
  installations: Array<{
    url: string;
    version: string;
    currentVersion: string;
  }>;
  loading: Boolean;

  constructor(private apollo: Apollo) {}

  ngOnInit() {
    this.loading = true;
    this.apollo
      .watchQuery<QueryResponse>({ query, pollInterval: 10000 })
      .valueChanges.pipe(map(({ data }) => data))
      .subscribe(data => {
        this.installations = data.installations
          .map(installation => ({
            ...installation,
            currentVersion: data.decidim.version
          }))
          .sort((a, b) => (a.name < b.name ? -1 : 1));

        this.loading = false;
      });
  }
}
