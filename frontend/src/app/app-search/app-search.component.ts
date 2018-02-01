import { Apollo } from "apollo-angular";
import { map, switchMap, tap } from "rxjs/operators";
import { Component, OnInit, ChangeDetectorRef } from "@angular/core";
import gql from "graphql-tag";
import { ActivatedRoute } from "@angular/router";
import { Observable } from "rxjs/Observable";

const query = gql`
  query SearchInstallations($version: String) {
    installations(version: $version) {
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
  selector: "app-search",
  templateUrl: "./app-search.component.html",
  styleUrls: ["./app-search.component.scss"]
})
export class AppSearch implements OnInit {
  installations$: Observable<
    Array<{
      url: string;
      version: string;
      currentVersion: string;
    }>
  >;
  loading: Boolean;

  constructor(
    private apollo: Apollo,
    private route: ActivatedRoute,
    private changeDetector: ChangeDetectorRef
  ) {}

  ngOnInit() {
    this.loading = true;

    this.installations$ = this.route.queryParams.pipe(
      switchMap(({ version }) =>
        this.apollo
          .watchQuery<QueryResponse>({
            query,
            variables: { version },
            pollInterval: 10000
          })
          .valueChanges.pipe(
            map(({ data }) =>
              data.installations
                .map(installation => ({
                  ...installation,
                  currentVersion: data.decidim.version
                }))
                .sort((a, b) => (a.name < b.name ? -1 : 1))
            )
          )
      ),
      tap(() => {
        this.loading = false;
        this.changeDetector.detectChanges();
      })
    );
  }
}
