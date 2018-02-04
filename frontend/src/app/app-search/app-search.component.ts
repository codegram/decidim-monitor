import { Apollo } from "apollo-angular";
import { map, switchMap, tap } from "rxjs/operators";
import { Component, OnInit, ChangeDetectorRef } from "@angular/core";
import gql from "graphql-tag";
import { ActivatedRoute } from "@angular/router";
import { Observable } from "rxjs/Observable";
import { DocumentNode } from "graphql";
import { AppSearchQuery } from "../graphql-types";

const query = require("./app-search.component.graphql");

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
  searchParams$: Observable<Object>;

  constructor(
    private apollo: Apollo,
    private route: ActivatedRoute,
    private changeDetector: ChangeDetectorRef
  ) {}

  ngOnInit() {
    this.searchParams$ = this.route.queryParams.pipe(
      map(({ version, tags }) => ({ version, tags })),
      map(params =>
        Object.keys(params).reduce(
          (state: String[], key: string) =>
            params[key] ? [...state, `${key}: ${params[key]}`] : state,
          []
        )
      )
    );

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
