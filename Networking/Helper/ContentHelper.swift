//  Copyright (c) 2021, Castcle and/or its affiliates. All rights reserved.
//  DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
//
//  This code is free software; you can redistribute it and/or modify it
//  under the terms of the GNU General Public License version 3 only, as
//  published by the Free Software Foundation.
//
//  This code is distributed in the hope that it will be useful, but WITHOUT
//  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
//  FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
//  version 3 for more details (a copy is included in the LICENSE file that
//  accompanied this code).
//
//  You should have received a copy of the GNU General Public License version
//  3 along with this work; if not, write to the Free Software Foundation,
//  Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
//
//  Please contact Castcle, 22 Phet Kasem 47/2 Alley, Bang Khae, Bangkok,
//  Thailand 10160, or visit www.castcle.com if you need additional information
//  or have any questions.
//
//  ContentHelper.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 19/11/2564 BE.
//

import Core
import RealmSwift
import SwiftyJSON

public class ContentHelper {
    public static let shared = ContentHelper()

    public func getAuthorRef(id: String) -> AuthorRealm? {
        if id.isEmpty {
            return nil
        } else {
            do {
                let realm = try Realm()
                return realm.objects(AuthorRealm.self).filter("id = '\(id)'").first
            } catch {
                return nil
            }
        }
    }

    public func getAuthorRef(castcleId: String) -> AuthorRealm? {
        if castcleId.isEmpty {
            return nil
        } else {
            do {
                let realm = try Realm()
                return realm.objects(AuthorRealm.self).filter("castcleId = '\(castcleId)'").first
            } catch {
                return nil
            }
        }
    }

    public func getContentRef(id: String) -> Content? {
        if id.isEmpty {
            return nil
        } else {
            do {
                let realm = try Realm()
                if let contentRef = realm.objects(ContentRef.self).filter("id = '\(id)'").first {
                    return self.contentRefToContent(contentRef: contentRef)
                } else {
                    return nil
                }
            } catch {
                return nil
            }
        }
    }

    public func authorRefToAuthor(authorRef: AuthorRealm) -> Author {
        let author: Author = Author()
        author.id = authorRef.id
        author.type = AuthorType(rawValue: authorRef.type) ?? .people
        author.castcleId = authorRef.castcleId
        author.displayName = authorRef.displayName
        author.overview = authorRef.overview
        author.followed = authorRef.followed
        author.blocking = authorRef.blocking
        author.blocked = authorRef.blocked
        author.avatar.thumbnail = authorRef.avatar
        author.verified.official = authorRef.official
        author.aggregator.message = ""
        return author
    }

    private func contentRefToContent(contentRef: ContentRef) -> Content {
        let content: Content = Content()
        content.id = contentRef.id
        content.authorId = contentRef.authorId
        content.type = ContentType(rawValue: contentRef.type) ?? .short
        content.message = contentRef.message
        content.createdAt = contentRef.createdAt
        content.updatedAt = contentRef.updatedAt

        // MARK: - Metric
        content.metrics.likeCount = contentRef.likeCount
        content.metrics.commentCount = contentRef.commentCount
        content.metrics.quoteCount = contentRef.quoteCount
        content.metrics.recastCount = contentRef.recastCount

        // MARK: - Participate
        content.participate.liked = contentRef.liked
        content.participate.commented = contentRef.commented
        content.participate.quoted = contentRef.quoted
        content.participate.recasted = contentRef.recasted
        content.participate.reported = contentRef.reported

        // MARK: - Photo
        if !contentRef.photoThumbnail.isEmpty {
            for index in 0..<contentRef.photoThumbnail.count {
                let photo: ImageInfo = ImageInfo()
                photo.thumbnail = contentRef.photoThumbnail[index]
                photo.fullHd = contentRef.photoFullHd[index]
                content.photo.append(photo)
            }
        }

        // MARK: - Link
        if !contentRef.linkType.isEmpty {
            let link: Link = Link()
            link.type = LinkType(rawValue: contentRef.linkType) ?? .other
            link.url = contentRef.linkUrl
            link.title = contentRef.linkTitle
            link.desc = contentRef.linkDesc
            link.imagePreview = contentRef.linkImagePreview
            content.link.append(link)
        }
        return content
    }

    public func updateContentRef(casts: [JSON]) {
        do {
            let realm = try Realm()
            try realm.write {
                casts.forEach { cast in
                    let contentRef = ContentRef().initCustom(json: cast)
                    realm.add(contentRef, update: .modified)
                }
            }
        } catch {}
    }

    public func updateReportRef(contentId: String) {
        do {
            let realm = try Realm()
            try realm.write {
                let reportRef = ReportRef()
                reportRef.id = contentId
                reportRef.updateAt = Date()
                realm.add(reportRef, update: .modified)
            }
        } catch {}
    }

    public func isReportContent(contentId: String) -> Bool {
        if contentId.isEmpty {
            return false
        } else {
            do {
                let realm = try Realm()
                if realm.objects(ReportRef.self).filter("id = '\(contentId)'").first != nil {
                    return true
                } else {
                    return false
                }
            } catch {
                return false
            }
        }
    }

    public func clearReportContent() {
        do {
            let realm = try Realm()
            let reportRealm = realm.objects(ReportRef.self)
            try realm.write {
                realm.delete(reportRealm)
            }
        } catch {}
    }
}
