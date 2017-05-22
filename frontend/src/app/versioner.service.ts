import { Apollo } from "apollo-angular";
import { Injectable } from '@angular/core';
import { Observable } from "rxjs/Observable";
import gql from "graphql-tag";
import compareVersion from "node-version-compare";

const query = gql`
{
  decidim {
    version
  }
}
`

interface QueryResponse {
  decidim: { version:string };
  loading: boolean;
}

@Injectable()
export class VersionerService {
  private version$: Observable<string>;

  constructor(private apollo: Apollo) {
    this.version$ = this.apollo.watchQuery<QueryResponse>({ query, pollInterval: 10000})
      .map(({ data}) => data.decidim.version );
  }

  checkOutdated(installationVersion:string) {
    return this.version$.map( version => compareVersion(installationVersion, version) < 0);
  }
}
