import { Apollo } from "apollo-angular";
import { map, switchMap, tap } from "rxjs/operators";
import { Component, OnInit, ChangeDetectorRef } from "@angular/core";
import gql from "graphql-tag";
import { ActivatedRoute } from "@angular/router";
import { Observable } from "rxjs/Observable";
import { DocumentNode } from "graphql";
import { AppSearchQuery } from "../graphql-types";

const query: DocumentNode = require("graphql-tag/loader!./app-search.component.graphql");

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
  version$: Observable<String>;

  constructor(
    private apollo: Apollo,
    private route: ActivatedRoute,
    private changeDetector: ChangeDetectorRef
  ) {}

  ngOnInit() {
    this.version$ = this.route.queryParams.pipe(map(params => params.version));

    this.installations$ = this.route.queryParams.pipe(
      switchMap(({ version, tags }) =>
        this.apollo
          .watchQuery<AppSearchQuery>({
            query,
            variables: { version, tags: tags ? tags.split(",") : null },
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
      )
    );
  }
}
