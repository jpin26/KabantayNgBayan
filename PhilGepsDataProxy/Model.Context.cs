﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data.Common;
using System.Data.EntityClient;
using System.Data.Metadata.Edm;
using System.Data.Objects.DataClasses;
using System.Data.Objects;
using System.Data;
using System.Diagnostics;
using System.Globalization;
using System.Linq;

namespace PhilGepsDataProxy
{
    public partial class Entities : ObjectContext
    {
        public const string ConnectionString = "name=Entities";
        public const string ContainerName = "Entities";
    
        #region Constructors
    
        public Entities()
            : base(ConnectionString, ContainerName)
        {
            Initialize();
        }
    
        public Entities(string connectionString)
            : base(connectionString, ContainerName)
        {
            Initialize();
        }
    
        public Entities(EntityConnection connection)
            : base(connection, ContainerName)
        {
            Initialize();
        }
    
        private void Initialize()
        {
            // Creating proxies requires the use of the ProxyDataContractResolver and
            // may allow lazy loading which can expand the loaded graph during serialization.
            ContextOptions.ProxyCreationEnabled = false;
            ObjectMaterialized += new ObjectMaterializedEventHandler(HandleObjectMaterialized);
        }
    
        private void HandleObjectMaterialized(object sender, ObjectMaterializedEventArgs e)
        {
            var entity = e.Entity as IObjectWithChangeTracker;
            if (entity != null)
            {
                bool changeTrackingEnabled = entity.ChangeTracker.ChangeTrackingEnabled;
                try
                {
                    entity.MarkAsUnchanged();
                }
                finally
                {
                    entity.ChangeTracker.ChangeTrackingEnabled = changeTrackingEnabled;
                }
                this.StoreReferenceKeyValues(entity);
            }
        }
    
        #endregion
    
        #region ObjectSet Properties
    
        public ObjectSet<UserProfile> UserProfiles
        {
            get { return _userProfiles  ?? (_userProfiles = CreateObjectSet<UserProfile>("UserProfiles")); }
        }
        private ObjectSet<UserProfile> _userProfiles;
    
        public ObjectSet<webpages_Membership> webpages_Membership
        {
            get { return _webpages_Membership  ?? (_webpages_Membership = CreateObjectSet<webpages_Membership>("webpages_Membership")); }
        }
        private ObjectSet<webpages_Membership> _webpages_Membership;
    
        public ObjectSet<webpages_OAuthMembership> webpages_OAuthMembership
        {
            get { return _webpages_OAuthMembership  ?? (_webpages_OAuthMembership = CreateObjectSet<webpages_OAuthMembership>("webpages_OAuthMembership")); }
        }
        private ObjectSet<webpages_OAuthMembership> _webpages_OAuthMembership;
    
        public ObjectSet<webpages_Roles> webpages_Roles
        {
            get { return _webpages_Roles  ?? (_webpages_Roles = CreateObjectSet<webpages_Roles>("webpages_Roles")); }
        }
        private ObjectSet<webpages_Roles> _webpages_Roles;
    
        public ObjectSet<businesscategory> businesscategories
        {
            get { return _businesscategories  ?? (_businesscategories = CreateObjectSet<businesscategory>("businesscategories")); }
        }
        private ObjectSet<businesscategory> _businesscategories;

        #endregion
    }
}