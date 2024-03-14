<!--
  Copyright (C) 2023 Nethesis S.r.l.
  SPDX-License-Identifier: GPL-3.0-or-later
-->
<template>
  <cv-grid fullWidth>
    <cv-row>
      <cv-column class="page-title">
        <h2>{{ $t("dns_records.title") }}</h2>
      </cv-column>
    </cv-row>
    <cv-row v-if="error.getDNSrecords">
      <cv-column>
        <NsInlineNotification
          kind="error"
          :title="$t('action.get-dns-records')"
          :description="error.getDNSrecords"
          :showCloseButton="false"
        />
      </cv-column>
    </cv-row>
    <cv-row>
      <cv-column>
        <cv-tile light>
          <cv-grid class="no-padding">
            <cv-row class="toolbar">
              <cv-column>
                <NsButton
                  kind="secondary"
                  :icon="Add20"
                  @click="q.isShowAddDNSRecordsModal = true"
                  >{{ $t("dns_records.add_dns_record") }}
                </NsButton>
              </cv-column>
            </cv-row>
            <cv-row>
              <cv-column>
                <NsDataTable
                  :allRows="DNSRecords"
                  :columns="i18nTableColumns"
                  :rawColumns="tableColumns"
                  :sortable="true"
                  :pageSizes="[10, 25, 50, 100]"
                  :overflow-menu="true"
                  isSearchable
                  :searchPlaceholder="$t('dns_records.search_record')"
                  :searchClearLabel="$t('common.clear_search')"
                  :noSearchResultsLabel="$t('common.no_search_results')"
                  :noSearchResultsDescription="
                    $t('common.no_search_results_description')
                  "
                  :isLoading="loading.getDNSrecords"
                  :skeletonRows="5"
                  :isErrorShown="!!error.getDNSrecords"
                  :errorTitle="error.getDNSrecords"
                  :itemsPerPageLabel="$t('pagination.items_per_page')"
                  :rangeOfTotalItemsLabel="
                    $t('pagination.range_of_total_items')
                  "
                  :ofTotalPagesLabel="$t('pagination.of_total_pages')"
                  :backwardText="$t('pagination.previous_page')"
                  :forwardText="$t('pagination.next_page')"
                  :pageNumberLabel="$t('pagination.page_number')"
                  @updatePage="tablePage = $event"
                >
                  <template slot="empty-state">
                    <NsEmptyState :title="$t('dns_records.no_records')">
                      <template #description>
                        <div>
                          {{ $t("dns_records.no_records_description") }}
                        </div>
                      </template>
                    </NsEmptyState>
                  </template>
                  <template slot="data">
                    <cv-data-table-row
                      v-for="(row, rowIndex) in tablePage"
                      :key="`${rowIndex}`"
                      :value="`${rowIndex}`"
                    >
                      <cv-data-table-cell>
                        <span>
                          {{ row.domain }}
                        </span>
                      </cv-data-table-cell>
                      <cv-data-table-cell>
                        <span>
                          {{ row.address }}
                        </span>
                      </cv-data-table-cell>
                      <cv-data-table-cell class="table-overflow-menu-cell">
                        <cv-overflow-menu flip-menu class="table-overflow-menu">
                          <cv-overflow-menu-item
                            danger
                            @click="setDNSrecords(row)"
                          >
                            <NsMenuItem
                              :icon="TrashCan20"
                              :label="$t('common.delete')"
                            />
                          </cv-overflow-menu-item>
                        </cv-overflow-menu>
                      </cv-data-table-cell>
                    </cv-data-table-row>
                  </template>
                </NsDataTable>
              </cv-column>
            </cv-row>
          </cv-grid>
        </cv-tile>
      </cv-column>
    </cv-row>
    <NsModal
      size="default"
      :visible="q.isShowAddDNSRecordsModal"
      @modal-hidden="q.isShowAddDNSRecordsModal = false"
      @primary-click="setDNSrecords"
      :primary-button-disabled="loading.setDNSrecords"
    >
      <template slot="title">{{ $t("dns_records.add_dns_record") }}</template>
      <template slot="content">
        <cv-form @submit.prevent="setDNSrecords">
          <cv-text-input
            :label="$t('dns_records.domain')"
            v-model="domain"
            :invalid-message="$t(error.domain)"
            ref="name"
          >
          </cv-text-input>
          <cv-text-input
            :label="$t('dns_records.address')"
            v-model="address"
            :invalid-message="$t(error.address)"
            ref="url"
          >
          </cv-text-input>
        </cv-form>
        <NsInlineNotification
          v-if="error.setDNSrecords"
          kind="error"
          :title="$t('action.set-dns-records')"
          :description="error.setDNSrecords"
          :showCloseButton="false"
        />
      </template>
      <template slot="secondary-button">{{ $t("common.close") }}</template>
      <template slot="primary-button">{{
        $t("dns_records.add_dns_record")
      }}</template>
    </NsModal>
  </cv-grid>
</template>

<script>
import to from "await-to-js";
import { mapState } from "vuex";
import {
  QueryParamService,
  UtilService,
  TaskService,
  IconService,
  PageTitleService,
} from "@nethserver/ns8-ui-lib";

export default {
  name: "DNSRecords",
  mixins: [
    TaskService,
    IconService,
    UtilService,
    QueryParamService,
    PageTitleService,
  ],
  pageTitle() {
    return this.$t("dns_records.title") + " - " + this.appName;
  },
  data() {
    return {
      q: {
        page: "dnsrecords",
        isShowAddDNSRecordsModal: false,
      },
      urlCheckInterval: null,
      DNSRecords: [],
      tablePage: [],
      tableColumns: ["domain", "address"],
      domain: "",
      address: "",
      loading: {
        getDNSrecords: false,
        setDNSrecords: false,
      },
      error: {
        getDNSrecords: "",
        setDNSrecords: "",
        domain: "",
        address: "",
      },
    };
  },
  computed: {
    ...mapState(["instanceName", "core", "appName"]),
    i18nTableColumns() {
      return this.tableColumns.map((column) => {
        return this.$t("dns_records." + column);
      });
    },
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      vm.watchQueryData(vm);
      vm.urlCheckInterval = vm.initUrlBindingForApp(vm, vm.q.page);
    });
  },
  beforeRouteLeave(to, from, next) {
    clearInterval(this.urlCheckInterval);
    next();
  },
  created() {
    this.getDNSrecords();
  },
  methods: {
    async getDNSrecords() {
      this.loading.getDNSrecords = true;
      this.error.getDNSrecords = "";
      const taskAction = "get-dns-records";
      const eventId = this.getUuid();

      // register to task error
      this.core.$root.$once(
        `${taskAction}-aborted-${eventId}`,
        this.getDNSrecordsAborted
      );

      // register to task completion
      this.core.$root.$once(
        `${taskAction}-completed-${eventId}`,
        this.getDNSrecordsCompleted
      );

      const res = await to(
        this.createModuleTaskForApp(this.instanceName, {
          action: taskAction,
          extra: {
            title: this.$t("action." + taskAction),
            isNotificationHidden: true,
            eventId,
          },
        })
      );
      const err = res[0];

      if (err) {
        console.error(`error creating task ${taskAction}`, err);
        this.error.getDNSrecords = this.getErrorMessage(err);
        this.loading.getDNSrecords = false;
        return;
      }
    },
    getDNSrecordsAborted(taskResult, taskContext) {
      console.error(`${taskContext.action} aborted`, taskResult);
      this.error.getDNSrecords = this.$t("error.generic_error");
      this.loading.getDNSrecords = false;
    },
    getDNSrecordsCompleted(taskContext, taskResult) {
      this.loading.getDNSrecords = false;
      this.DNSRecords = taskResult.output.records;
    },
    validateDNSrecords() {
      this.clearErrors(this);
      let isValidationOk = true;

      if (!this.domain) {
        // domain cannot be empty
        this.error.domain = this.$t("common.required");

        if (isValidationOk) {
          isValidationOk = false;
        }
      }
      if (!this.address) {
        // address cannot be empty
        this.error.address = this.$t("common.required");

        if (isValidationOk) {
          isValidationOk = false;
        }
      }

      return isValidationOk;
    },
    setDNSvalidationFailed(validationErrors) {
      this.loading.setDNSrecords = false;

      for (const validationError of validationErrors) {
        const fieldToken = validationError.field.split(".").pop();

        if (fieldToken === "address") {
          this.error.address = this.$t("error." + validationError.error);
        }
        if (fieldToken === "domain") {
          this.error.domain = this.$t("error." + validationError.error);
        }
      }
    },
    // This function can be used for create a record or delete a record
    // If you call it without the param, you add the record
    // Else, you delete the record that you pass to it
    async setDNSrecords(recordToDelete) {
      const isValidationOk = this.validateDNSrecords();
      if (!isValidationOk && !recordToDelete) {
        return;
      }

      this.loading.setDNSrecords = true;
      const taskAction = "set-dns-records";
      const eventId = this.getUuid();

      // register to task error
      this.core.$root.$once(
        `${taskAction}-aborted-${eventId}`,
        this.setDNSrecordsAborted
      );

      // register to task validation
      this.core.$root.$once(
        `${taskAction}-validation-failed-${eventId}`,
        this.setDNSvalidationFailed
      );

      // register to task completion
      this.core.$root.$once(
        `${taskAction}-completed-${eventId}`,
        this.setDNSrecordsCompleted
      );

      const records = recordToDelete
        ? this.DNSRecords.filter(
            (record) =>
              record.domain !== recordToDelete.domain ||
              record.address !== recordToDelete.address
          )
        : [
            ...this.DNSRecords,
            {
              domain: this.domain,
              address: this.address,
            },
          ];

      const res = await to(
        this.createModuleTaskForApp(this.instanceName, {
          action: taskAction,
          data: {
            records: records,
          },
          extra: {
            title: this.$t(
              recordToDelete
                ? "dns_records.delete_dns_record"
                : "dns_records.add_dns_record"
            ),
            description: this.$t("common.processing"),
            eventId,
          },
        })
      );
      const err = res[0];

      if (err) {
        console.error(`error creating task ${taskAction}`, err);
        this.error.setDNSrecords = this.getErrorMessage(err);
        this.loading.setDNSrecords = false;
        return;
      }
    },
    setDNSrecordsAborted(taskResult, taskContext) {
      console.error(`${taskContext.action} aborted`, taskResult);
      this.error.setDNSrecords = this.$t("error.generic_error");
      this.loading.setDNSrecords = false;
    },
    setDNSrecordsCompleted() {
      this.loading.setDNSrecords = false;

      // reload configuration
      this.q.isShowAddDNSRecordsModal = false;
      this.domain = "";
      this.address = "";
      this.clearErrors(this);
      this.getDNSrecords();
    },
  },
};
</script>

<style scoped lang="scss">
@import "../styles/carbon-utils";
</style>
