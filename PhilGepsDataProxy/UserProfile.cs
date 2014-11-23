//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Globalization;
using System.Runtime.Serialization;

namespace PhilGepsDataProxy
{
    [DataContract(IsReference = true)]
    [KnownType(typeof(webpages_Roles))]
    public partial class UserProfile: IObjectWithChangeTracker, INotifyPropertyChanged
    {
        #region Primitive Properties
    
        [DataMember]
        public int UserId
        {
            get { return _userId; }
            set
            {
                if (_userId != value)
                {
                    if (ChangeTracker.ChangeTrackingEnabled && ChangeTracker.State != ObjectState.Added)
                    {
                        throw new InvalidOperationException("The property 'UserId' is part of the object's key and cannot be changed. Changes to key properties can only be made when the object is not being tracked or is in the Added state.");
                    }
                    _userId = value;
                    OnPropertyChanged("UserId");
                }
            }
        }
        private int _userId;
    
        [DataMember]
        public string UserName
        {
            get { return _userName; }
            set
            {
                if (_userName != value)
                {
                    _userName = value;
                    OnPropertyChanged("UserName");
                }
            }
        }
        private string _userName;

        #endregion
        #region Navigation Properties
    
        [DataMember]
        public TrackableCollection<webpages_Roles> webpages_Roles
        {
            get
            {
                if (_webpages_Roles == null)
                {
                    _webpages_Roles = new TrackableCollection<webpages_Roles>();
                    _webpages_Roles.CollectionChanged += Fixupwebpages_Roles;
                }
                return _webpages_Roles;
            }
            set
            {
                if (!ReferenceEquals(_webpages_Roles, value))
                {
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        throw new InvalidOperationException("Cannot set the FixupChangeTrackingCollection when ChangeTracking is enabled");
                    }
                    if (_webpages_Roles != null)
                    {
                        _webpages_Roles.CollectionChanged -= Fixupwebpages_Roles;
                    }
                    _webpages_Roles = value;
                    if (_webpages_Roles != null)
                    {
                        _webpages_Roles.CollectionChanged += Fixupwebpages_Roles;
                    }
                    OnNavigationPropertyChanged("webpages_Roles");
                }
            }
        }
        private TrackableCollection<webpages_Roles> _webpages_Roles;

        #endregion
        #region ChangeTracking
    
        protected virtual void OnPropertyChanged(String propertyName)
        {
            if (ChangeTracker.State != ObjectState.Added && ChangeTracker.State != ObjectState.Deleted)
            {
                ChangeTracker.State = ObjectState.Modified;
            }
            if (_propertyChanged != null)
            {
                _propertyChanged(this, new PropertyChangedEventArgs(propertyName));
            }
        }
    
        protected virtual void OnNavigationPropertyChanged(String propertyName)
        {
            if (_propertyChanged != null)
            {
                _propertyChanged(this, new PropertyChangedEventArgs(propertyName));
            }
        }
    
        event PropertyChangedEventHandler INotifyPropertyChanged.PropertyChanged{ add { _propertyChanged += value; } remove { _propertyChanged -= value; } }
        private event PropertyChangedEventHandler _propertyChanged;
        private ObjectChangeTracker _changeTracker;
    
        [DataMember]
        public ObjectChangeTracker ChangeTracker
        {
            get
            {
                if (_changeTracker == null)
                {
                    _changeTracker = new ObjectChangeTracker();
                    _changeTracker.ObjectStateChanging += HandleObjectStateChanging;
                }
                return _changeTracker;
            }
            set
            {
                if(_changeTracker != null)
                {
                    _changeTracker.ObjectStateChanging -= HandleObjectStateChanging;
                }
                _changeTracker = value;
                if(_changeTracker != null)
                {
                    _changeTracker.ObjectStateChanging += HandleObjectStateChanging;
                }
            }
        }
    
        private void HandleObjectStateChanging(object sender, ObjectStateChangingEventArgs e)
        {
            if (e.NewState == ObjectState.Deleted)
            {
                ClearNavigationProperties();
            }
        }
    
        protected bool IsDeserializing { get; private set; }
    
        [OnDeserializing]
        public void OnDeserializingMethod(StreamingContext context)
        {
            IsDeserializing = true;
        }
    
        [OnDeserialized]
        public void OnDeserializedMethod(StreamingContext context)
        {
            IsDeserializing = false;
            ChangeTracker.ChangeTrackingEnabled = true;
        }
    
        protected virtual void ClearNavigationProperties()
        {
            webpages_Roles.Clear();
        }

        #endregion
        #region Association Fixup
    
        private void Fixupwebpages_Roles(object sender, NotifyCollectionChangedEventArgs e)
        {
            if (IsDeserializing)
            {
                return;
            }
    
            if (e.NewItems != null)
            {
                foreach (webpages_Roles item in e.NewItems)
                {
                    if (!item.UserProfiles.Contains(this))
                    {
                        item.UserProfiles.Add(this);
                    }
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        if (!item.ChangeTracker.ChangeTrackingEnabled)
                        {
                            item.StartTracking();
                        }
                        ChangeTracker.RecordAdditionToCollectionProperties("webpages_Roles", item);
                    }
                }
            }
    
            if (e.OldItems != null)
            {
                foreach (webpages_Roles item in e.OldItems)
                {
                    if (item.UserProfiles.Contains(this))
                    {
                        item.UserProfiles.Remove(this);
                    }
                    if (ChangeTracker.ChangeTrackingEnabled)
                    {
                        ChangeTracker.RecordRemovalFromCollectionProperties("webpages_Roles", item);
                    }
                }
            }
        }

        #endregion
    }
}
